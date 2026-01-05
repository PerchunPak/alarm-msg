{
  fetchPypi,
  python3Packages,
}:

let
  pname = "discord-protos";
  version = "0.0.2";
in
python3Packages.buildPythonPackage {
  inherit pname version;
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-I5U6BfMr7ttAtwjsS0V1MKYZaknI110zeukoKipByZc=";
  };

  build-system = [ python3Packages.setuptools ];

  dependencies = with python3Packages; [
    protobuf
  ];

  doCheck = false;
}
