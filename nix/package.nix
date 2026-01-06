{ python3Packages }:
python3Packages.buildPythonApplication {
  name = "alarm-msg";
  src = ./..;

  pyproject = true;
  build-system = [ python3Packages.uv-build ];

  dependencies = with python3Packages; [
    discordpy-self
  ];
}
