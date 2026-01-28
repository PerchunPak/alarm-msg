{
  gst_all_1,
  wrapGAppsNoGuiHook,
  python3Packages,
}:
python3Packages.buildPythonApplication rec {
  name = "alarm-msg";
  src = ./..;

  postPatch = ''
    substituteInPlace src/alarm_msg/__init__.py \
      --replace-fail @sound@ ${../alarm.mp3}
  '';

  pyproject = true;
  build-system = [ python3Packages.uv-build ];

  dependencies =
    with python3Packages;
    [
      discordpy-self
      python-dotenv
    ]
    ++ nativeBuildInputs;

  nativeBuildInputs = with gst_all_1; [
    wrapGAppsNoGuiHook
    gst-plugins-base
    gstreamer
    gst-plugins-good
  ];
}
