final: prev: {
  alarm-msg = final.callPackage ./package.nix { };

  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (pfinal: pprev: {
      discordpy-self = pfinal.callPackage ./discord-py-self.nix { };
      discord-protos = pfinal.callPackage ./discord-protos.nix { };
    })
  ];
}
