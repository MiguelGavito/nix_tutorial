{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "fullstack-dev";
  
  buildInputs = with pkgs; [
    # Frontend
    nodejs_20
    nodePackages.npm
    
    # Backend
    python3
    python3Packages.flask
    python3Packages.flask-cors
    python3Packages.psutil
    
    # Utilities
    git
    curl
  ];
  
  shellHook = ''
    echo "🚀 Full-Stack Dev Environment (Ready)"
    echo "Frontend: Node $(node --version)"
    echo "Backend:  Python $(python3 --version)"
    echo "Backend exposes system stats on port 5000"
    echo "Frontend dashboard runs on port 3000"
    echo ""
    echo "Start backend: python3 backend.py"
    echo "Start frontend: node frontend.js"
    echo "Open dashboard: http://localhost:3000"
  '';
}
