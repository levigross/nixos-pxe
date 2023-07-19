{
  description = "A generic and minimal netbooting OS for my homelab";

  inputs =
    {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
      sops-nix.url = "github:Mic92/sops-nix";
    };

  outputs = { self, nixpkgs, sops-nix, ... }:
    let
      system = "aarch64-linux";
    in
    {
      nixosConfigurations = {
        generic = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            sops-nix.nixosModules.sops
          ];
        };
      };
      packages.${system}.default = nixpkgs.legacyPackages.${system}.symlinkJoin {
        name = "netboot";
        paths = with self.nixosConfigurations.generic.config.system.build; [
          netbootRamdisk
          kernel
          netbootIpxeScript
        ];
        preferLocalBuild = true;
      };
    };
}
