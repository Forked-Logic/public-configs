{ config, pkgs, ... }:

{
  users.users.<USERNAME> = {
    isNormalUser = true;
    description = "<DESCRIPTION>";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };
}
