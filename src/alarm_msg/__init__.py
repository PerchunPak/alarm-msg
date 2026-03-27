import datetime as dt
import logging
import os
import subprocess
import typing as t
from pathlib import Path

import discord
from discord import DMChannel, Member, Message, VoiceState
from dotenv import load_dotenv

assert load_dotenv(Path.cwd() / ".env"), "pls create .env file"
discord.utils.setup_logging()
logger = logging.getLogger(__name__)

SOUND_FILE = "@sound@"
TOKEN = os.environ["DISCORD_TOKEN"]
USER_ID = int(os.environ["USER_ID"])


class MyClient(discord.Client):
    def __init__(self, *args: t.Any, **kwargs: t.Any) -> None:
        super().__init__(*args, **kwargs)

        self._is_in_the_vc: int | None = None
        self._in_voice_since: dt.datetime = dt.datetime.min

    async def on_ready(self):
        logger.info("Logged on as %s", self.user)

    async def on_message(self, message: Message) -> None:
        if message.author.id != USER_ID:
            return

        if (
            self._is_in_the_vc
            and self._in_voice_since < dt.datetime.now() - dt.timedelta(minutes=10)
        ):
            logger.info(
                "Skipping, because user is currently in "
                + f"THE voice call since {self._in_voice_since}"
            )
            return

        logger.info("Got message: %s", message)
        self.play_alarm()

    def play_alarm(self) -> None:
        cmd = "gst-launch-1.0 filesrc location=alarm.mp3 ! mpegaudioparse ! mpg123audiodec ! audioconvert ! audioresample ! pulsesink device=alsa_output.pci-0000_05_00.6.analog-stereo volume=1.0"
        subprocess.check_output(cmd.split(" "))

    async def on_voice_state_update(
        self, member: Member, _before: VoiceState, after: VoiceState
    ) -> None:
        assert self.user is not None
        if (
            member.id != self.user.id
            or after.channel is None
            or not isinstance(after.channel, DMChannel)
        ):
            return
        self._is_in_the_vc = after.channel.recipient.id == USER_ID
        self._in_voice_since = dt.datetime.now()


def main() -> None:
    MyClient().run(TOKEN)
