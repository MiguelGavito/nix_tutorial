{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "fullstack-dev";
  
  buildInputs = with pkgs; [
    # Frontend
    nodejs_20
    nodePackages.npm
    
    # Backend
    python3
    python3Packages.pip
    python3Packages.flask
    python3Packages.flask-cors
    
    # Utilities
    git
    curl
  ];
  
  shellHook = ''
    echo "🚀 Full-Stack Development Environment"
    echo "Frontend: Node $(node --version)"
    echo "Backend:  Python $(python3 --version)"
    echo ""
    echo "Try: python3 backend.py &"
    echo "Then: node frontend.js"
  '';
}
