# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant. (WiFi works for me without this).

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled by default in most desktop environments).
  # services.xserver.libinput.enable = true;

  # Enable rootless Docker.
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set nix pkg manager max download buffer size.
  nix.settings.download-buffer-size = 524288000;

  # Install firefox.
  programs.firefox.enable = true;

  # Enable dconf (I use this primarily for configuring some Gnome Desktop Environment behaviours).
  programs.dconf.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.

  # Enable ping / traceroute command.
  programs.mtr.enable = true;

  # Enable GPG agent (for signing git commits) and use gnome3 UI for entering passphrases.
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  # Define packages which are installed system-wide (for all users).
  # To search, run: 'nix search wget', or visit https://search.nixos.org
  environment.systemPackages = with pkgs; [
    ## Shell. ##
    bash
    ## Compression. ##
    gnutar
    gzip
    lz4
    unzip
    xz
    zip
    ## Editors. ##
    # nano and gnome text editor are installed by default.
    vim
    ## Encoding. ##
    tinyxxd
    ## IDEs. ##
    jetbrains.idea-community-bin
    ## Script/Software Validation Tooling. ##
    shellcheck
    ## PKCS. ##
    gnupg
    gpa
    pinentry-gnome3
    pinentry-curses
    ## General Utilities. ##
    binutils
    coreutils
    diffutils
    findutils
    inetutils
    ncurses
    parallel
    tree
    ## Network tools. ##
    curl
    mtr
    netcat
    wget
    ## Rice. ##
    fastfetch
    ## VCS. ##
    gh
    git
  ];

  # Configure command aliases (convenient shorthand) for BASH shell.
  programs.bash.shellAliases = {
    e = "exit";
    ff = "fastfetch";
    flake1 = "sudo nix  --extra-experimental-features nix-command  --extra-experimental-features flakes   flake  update  --flake /etc/nixos/";
    flake2 = "sudo nixos-rebuild  switch  --flake /etc/nixos/";
    gadd = "git add";
    gcho = "git checkout";
    gcomm = "git commit -m";
    gdiff = "git diff";
    gfetch = "git fetch";
    ginit = "git init";
    glog = "git log";
    glogn = "git log -n";
    gpullff = "git pull --ff-only";
    gpush = "git push";
    gres = "git reset";
    gresh = "git reset --hard";
    gress = "git reset --soft";
    grest = "git restore";
    grm = "git rm";
    gstat = "git status";
    l = "ls -alh";
    la = "ls -al";
    ll = "ls -l";
    ncu = "sudo nix-channel --update";
    nrb = "sudo nixos-rebuild boot";
    nrs = "sudo nixos-rebuild switch";
    nrefresh = "sudo nix-channel --update  &&  sudo nixos-rebuild switch";
    nupgrade = "sudo nix-channel --update  &&  sudo nixos-rebuild boot  &&  sudo reboot";
    tre = "tput reset";
    treee = "tree -I pkg --prune";
    trf = "tput reset  &&  fastfetch";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.apl = {
    isNormalUser = true;
    description = "ph4n70m nuk3r";
    # Groups for: Running docker without using sudo ; Changing network settings ; Running 'su' (switch user).
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    # BASH is the default shell, some prefer zsh or fish.
    #shell = pkgs.bash;
    # Optionally define additional pakages for specific user account.
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Enable Stylix for customised themes
  stylix.enable = true;
   # I like dark themes :)
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-city-dark.yaml";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and RECOMMENDED TO LEAVE
  # THIS VALUE AT THE RELEASE VERSION OF THE FIRST INSTALL OF THIS SYSTEN.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the above comment?
}
