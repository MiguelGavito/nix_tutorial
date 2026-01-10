{ config, pkgs, ... }:

{
  # Home Manager needs this version
  home.stateVersion = "25.11";

  # Add packages to your system
  home.packages = with pkgs; [
    kew       # Terminal music player
    ytmdl     # YouTube music downloader with metadata
  ];

  /* Alternatively, you can specify packages like this:
  
  home.packages = [
    pkgs.kew
    pkgs.ytmdl 
  ];

  is the same
  */

  # Configure zsh shell (optional but recommended)
  programs.zsh = {
    enable = true;
    
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";  # Nice theme with git info
      plugins = [ "git" "sudo" "history" ];
    };
    
    # Type suggestions as you type
    autosuggestion.enable = true;
    
    # Color syntax while typing
    syntaxHighlighting.enable = true;
    
    # Handy shell aliases
    shellAliases = {
      music = "kew";
      download = "ytmdl";
    };
  };

  # Alternative: if you don't use zsh, remove the programs.zsh section above
  # and just keep home.packages. Home Manager will still install kew and ytmdl.
}

