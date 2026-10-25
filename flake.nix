{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
		disko = {
			url = "github:nix-community/disko";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		# TODO: Define pkgs
	};
	outputs = { flake-utils, nixpkgs, disko, ... }:
	let
		system = "x86_64-linux";
		pkgs = import nixpkgs { inherit system; overlays = [ (import ./hosts/fileserver/pkgs/overlay.nix) ]; };
	in {
    nixosConfiguration.fileserver = {
      modules = [
        disko.nixosModules.disko
        ./hosts/fileserver/system/disko.nix
        ./hosts/fileserver/system/configuration.nix
        ./hosts/fileserver/system/hardware-configuration.nix
      ];
    };
	}
	//
	flake-utils.lib.eachDefaultSystem(system: {
		devShells.default = pkgs.mkShell {
			packages = with pkgs; [
        nixos-anywhere
        openssl
				# Packages for working with the server go here 
				# (packages that would be installed on this machine locally with nix develop!)
			];
		};
	}); # Development shell for working on the server configuration
}
