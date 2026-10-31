{
  description = "NixOS do Luiz — tudo no unstable; Home Manager só para pacotes e serviços";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # A branch padrão (master) do Home Manager acompanha o nixpkgs-unstable.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Mango e Zen não estão no nixpkgs; os flakes deles usam o nosso nixpkgs.
    mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, mango, ... }@inputs:
    let
      # Base comum às duas máquinas; cada host acrescenta os seus módulos.
      mkHost = hostModules:
        nixpkgs.lib.nixosSystem {
          modules = [
            mango.nixosModules.mango
            home-manager.nixosModules.home-manager
            ./modules/base.nix
            ./modules/desktop.nix
            {
              home-manager = {
                useGlobalPkgs = true;      # mesmo nixpkgs (e allowUnfree) do sistema
                useUserPackages = true;
                backupFileExtension = "hm-backup";
                extraSpecialArgs = { inherit inputs; };
                users.ldlpiao = import ./home;
              };
            }
          ] ++ hostModules;
        };
    in
    {
      nixosConfigurations = {
        # Intel, sem NVIDIA
        thinkpad = mkHost [ 
	  ./hosts/thinkpad 
	];

        # RTX: NVIDIA + jogos
        dell = mkHost [
          ./hosts/dell
          ./modules/nvidia.nix
          ./modules/gaming.nix
	  ./modules/streaming.nix
        ];
      };
    };
}
