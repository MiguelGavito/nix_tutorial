{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "music-player-test";
  
  buildInputs = with pkgs; [
    kew      # Terminal music player
    ytmdl    # YouTube music downloader with metadata
  ];
  
  shellHook = ''
    echo "🎵 Music Player Test Environment"
    echo "Available commands:"
    echo "  ytmdl - Download music from YouTube"
    echo "  kew   - Terminal music player"
    echo ""
    echo "Example: ytmdl \"Scarlet Forest\""
    kew --version 2>/dev/null && echo "kew: $(kew --version)"
    ytmdl --version 2>/dev/null && echo "ytmdl: $(ytmdl --version)" || echo "ytmdl loaded"
  '';
}
