{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "nodejs-api-monitor";
  
  # These are the tools Nix provides for you
  buildInputs = with pkgs; [
    nodejs_20
    nodePackages.npm
  ];
  
  shellHook = ''
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "⚡ API Health Monitor Environment Ready!"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Node:   $(node --version)"
    echo "npm:    $(npm --version)"
    echo ""
    echo "First time? Run: npm install"
    echo "Then run: node app.js"
    echo "Then: Open http://localhost:3000"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  '';
}
