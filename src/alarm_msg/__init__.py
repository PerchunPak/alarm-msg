import logging
import os

import discord
from dotenv import load_dotenv

load_dotenv()
discord.utils.setup_logging()
logger = logging.getLogger(__name__)

TOKEN = os.environ["DISCORD_TOKEN"]
USER_ID = os.environ["USER_ID"]


class MyClient(discord.Client):
    async def on_ready(self):
        logger.info("Logged on as %s", self.user)

    async def on_message(self, message):
        if message.author_id != USER_ID:
            return

        breakpoint()


def main() -> None:
    MyClient().run(TOKEN)
