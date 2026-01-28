import logging
import os
import subprocess
from pathlib import Path

import discord
from dotenv import load_dotenv

assert load_dotenv(Path.cwd() / ".env"), "pls create .env file"
discord.utils.setup_logging()
logger = logging.getLogger(__name__)

SOUND_FILE = "@sound@"
TOKEN = os.environ["DISCORD_TOKEN"]
USER_ID = int(os.environ["USER_ID"])


class MyClient(discord.Client):
    async def on_ready(self):
        logger.info("Logged on as %s", self.user)

    async def on_message(self, message):
        if message.author.id != USER_ID:
            return
        logger.info("Got message: %s", message)

        self.play_alarm()

    def play_alarm(self) -> None:
        cmd = "gst-launch-1.0 filesrc location=alarm.mp3 ! mpegaudioparse ! mpg123audiodec ! audioconvert ! audioresample ! pulsesink device=alsa_output.pci-0000_05_00.6.analog-stereo volume=1.0"
        subprocess.check_output(cmd.split(" "))


def main() -> None:
    MyClient().run(TOKEN)
