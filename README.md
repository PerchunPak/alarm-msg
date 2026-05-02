# alarm-msg

Produce alarm-msg when specific person sends you a message.

## Features:

- Plays `alarm.mp3` on message
- Filters by user ID
- Detects if you are currently in a voice channel with specified user for more
  than 10 minutes, and doesn't play alarm.

## Usage

- `cp .env.example .env` and put your token and desired user ID in `.env`.
  See also https://discordpy-self.readthedocs.io/en/latest/authenticating.html
- `nix run .` starts the bot
