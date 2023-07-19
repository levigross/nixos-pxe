{ config, pkgs, lib, modulesPath, ... }:
{

  imports = [
    (modulesPath + "/installer/netboot/netboot-minimal.nix")
  ];


  networking.hostName = "aleph";
  networking.networkmanager.enable = true;
  networking.hostId = "f27617dd";
  networking.wireless.enable = false;
  boot = {
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    supportedFilesystems = [ "zfs" ];
    kernelModules = [ "kvm-intel" "veth" ];
  };



  networking.dhcpcd.enable = true;

  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;


  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  environment.noXlibs = lib.mkForce false; # This is a headless server, it does not need X

  users = {
    mutableUsers = false;

    users.human = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB95OPMyd0o8iI7cT+7dvQss9v7TmJxjpyI0waV8c9D+" ];
      packages = with pkgs; [
        bash
        bat
        helix
      ];
    };
  };


  services.openssh = {
    settings.PasswordAuthentication = false;
    enable = true;
  };
  networking.firewall.enable = false;

  system.stateVersion = "23.05";
}
