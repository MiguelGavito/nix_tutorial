{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "python-flask-dev";
  
  buildInputs = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.flask
    python3Packages.flask-cors
    python3Packages.requests
    python3Packages.python-dotenv
  ];
  
  shellHook = ''
    echo "🐍 Python Flask Development Environment"
    python3 --version
    echo "Try: python3 app.py"
  '';
}
