{
  aiohttp,
  audioop-lts,
  buildPythonPackage,
  curl-cffi,
  discord-protos,
  fetchFromGitHub,
  setuptools,
  tzlocal,
}:

let
  pname = "discord.py-self";
  version = "0-unstable-2025-12-05";
in
buildPythonPackage {
  inherit pname version;
  pyproject = true;

  src = fetchFromGitHub {
    owner = "dolfies";
    repo = "discord.py-self";
    rev = "21390fedece3601cd96d199e4595e2b546471495";
    hash = "sha256-Ylx/KSyVaSPasP3HaoLZ7xJ5jIW1tW2cwETE1/8Zd90=";
  };

  build-system = [ setuptools ];

  dependencies = [
    aiohttp
    curl-cffi
    tzlocal
    discord-protos
    audioop-lts
  ];

  # Only have integration tests with discord
  doCheck = false;

  pythonImportsCheck = [ "discord" ];
}
