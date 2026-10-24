{
	inputs = {
		nixpkgs.url = "guthub:NixOS/nixpkgs/nixos-26.05";
		disko = {
			url = "github:nix-community/disko";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		# TODO: Define pkgs
	};
  modules = [
    disco.nixosModules.disco
    ./hosts/fileserver/system/disco.nix
    ./hosts/fileserver/system/configuration.nix
    ./hosts/fileserver/system/hardware-configuration.nix
  ];
	outputs = { flake-utils, nixpkgs, disko, ... }:
	let
		system = "x86_64-linux";
		pkgs = import nixpkgs { inherit system; overlays = [./pkgs/overlay.nix]; };
	in {

	
		
	}
	//
	flake-utils.lib.eachDefaultSystem(system: {
		devShells.default = pkgs.mkShell {
			packages = with pkgs; [
				# Packages for working with the server go here 
				# (packages that would be installed on this machine locally with nix develop!)
			];
		};
	}); # Development shell for working on the server configuration
}
