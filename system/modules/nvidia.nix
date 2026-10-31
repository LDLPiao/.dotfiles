{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = true;              # Turing+ (RTX 20/30); confirme na wiki do NixOS
    modesetting.enable = true;
  };
}
