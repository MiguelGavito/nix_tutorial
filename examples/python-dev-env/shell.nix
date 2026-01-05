{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "python-github-analyzer";
  
  # These are the tools Nix provides for you
  buildInputs = with pkgs; [
    python3
    python3Packages.requests
    python3Packages.rich
  ];
  
  shellHook = ''
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🐍 GitHub Repo Analyzer Environment Ready!"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Python:   $(python3 --version)"
    echo "Packages: requests, rich (for pretty output)"
    echo ""
    echo "Try: python3 app.py octocat/Hello-World"
    echo "Or:  python3 app.py <your-username>/<repo-name>"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  '';
}
