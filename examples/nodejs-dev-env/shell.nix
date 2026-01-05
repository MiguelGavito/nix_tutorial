{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "nodejs-dev";
  
  buildInputs = with pkgs; [
    nodejs_20
    nodePackages.npm
    nodePackages.pnpm
  ];
  
  shellHook = ''
    echo "⚡ Node.js Development Environment"
    node --version
    npm --version
    echo "Try: npm init -y && npm install express"
  '';
}
