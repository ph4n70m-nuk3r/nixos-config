{ pkgs, ... }:

{
  # Enable BASH Shell.
  programs.bash = {
    enable = true;
  };

  # Enable and configure Git.
  programs.git = {
    enable = true;
    # Comment out the lines below or replace with your own information.
    userName = "ph4n70m-nuk3r";
    userEmail = "ph4n70m.nuk3r@gmail.com";
    signing.key = "B2AA9B9B8AB2F171";
    signing.signByDefault = true;
  };

  # I have configured Stylix at the system level.
  stylix.autoEnable = false;

  # User packages which are managed by home-manager.
  home.packages = with pkgs; [
    gnomeExtensions.hide-top-bar
  ];

  # DConf settings for Gnome Desktop Environment.
  dconf = {
    enable = true;
    settings = {
      # Prefer dark theme.
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      # Enable user extensions, specifically: 'hide-top-bar' for Gnome Desktop Environment.
      "org/gnome/shell" = {
        disable-user-extensions = false; # enables user extensions
        enabled-extensions = [
          # Put UUIDs of extensions that you want to enable here.
          # If the extension you want to enable is packaged in nixpkgs,
          # you can easily get its UUID by accessing its extensionUuid
          # field (look at the following example).
          pkgs.gnomeExtensions.hide-top-bar.extensionUuid
        ];
      };

      # Configure individual extensions
      "org/gnome/shell/extensions/hide-top-bar" = {
        intellihide = false;
        show-on-edge = true;
        edge-reveal-width = 10;
      };

      ## Custom keybinding for gnome terminal (kgx). ##
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Ctrl><Alt>t";
        command = "kgx";
        name = "open-terminal";
      };
    };
  };

  ## Recommended to leave this value at the version you first installed. ##
  home.stateVersion = "24.11";
}
