{
  python3Packages,
}:
python3Packages.buildPythonApplication (finalAttrs: {
  name = "alarm-msg";
  src = ./.;

  dependencies = [ ];
})
