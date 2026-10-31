{ pkgs, ... }:
{
  nixpkgs.hostPlatform = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  networking.networkmanager.enable = true;
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "pt_BR.UTF-8";

  users.users.ldlpiao = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "dialout"];
    shell = pkgs.zsh;
  };

  # zsh só habilitado; o prompt (starship) e o resto ficam no SEU .zshrc (bare repo).
  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

#  virtualisation.podman.enable = true;   # backend do distrobox

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    wlr.settings.screencast = {
      chooser_type = "simple";
      chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";  # escolhe o monitor
      max_fps = 60;
    };
    config.mango = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.ScreenCast" = "wlr";
      "org.freedesktop.impl.portal.Screenshot" = "wlr";
    };
  };

  # Só o essencial do sistema; programas de usuário ficam em ../home/default.nix.
  environment.systemPackages = with pkgs; [
    wget
    curl
  ];

  environment.variables = {
    EDITOR = "vis";
  };
}
