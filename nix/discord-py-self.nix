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
  version = "2.1.0";
in
buildPythonPackage {
  inherit pname version;
  pyproject = true;

  src = fetchFromGitHub {
    owner = "dolfies";
    repo = "discord.py-self";
    tag = "v${version}";
    hash = "sha256-jVz3uGU+4E5Awbk6ZYAsXvEpClNHm2QN1RpBTIiQTpE=";
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
