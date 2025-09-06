{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      fhs = pkgs.buildFHSEnv {
        name = "fhs-shell";
        targetPkgs = pkgs: with pkgs; [
          bc openssl openssl.dev zlib zlib.dev zstd zstd.dev glibc glibc.dev libxml2_13 libxml2_13.dev lz4
        ];
      };
    in
      {
        devShells.${system}.default = fhs.env;
      };
}
