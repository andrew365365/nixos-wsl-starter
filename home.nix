{
  # FIXME: uncomment the next line if you want to reference your GitHub/GitLab access tokens and other secrets
  # secrets,
  config,
  pkgs,
  username,
  nix-index-database,
  ...
}: let
  unstable-packages = with pkgs.unstable; [
    bat
    bottom
    coreutils
    curl
    du-dust
    fd
    findutils
    fx
    git
    git-crypt
    htop
    jq
    killall
    nnn
    eza
    mosh
    neovim
    procs
    ripgrep
    sd
    tmux
    tree
    unzip
    vim
    wget
    zip
    tldr
    lazygit
  ];

  stable-packages = with pkgs; [
    # key tools
    neovim-remote
    gh # for bootstrapping
    just
    trash-cli

    # core languages
    go
    lua
    nodejs
    python312
    typescript
    zig
    luarocks
    clang
    rustup

    # rust stuff
    cargo-cache
    cargo-expand

    # local dev stuf
    mkcert
    httpie

    # treesitter
    tree-sitter

    # language servers
    ccls # c / c++
    gopls
    pkgs.nodePackages.typescript-language-server
    pkgs.nodePackages.vscode-langservers-extracted # html, css, json, eslint
    pkgs.nodePackages.yaml-language-server
    lua-language-server
    nil # nix
    pkgs.nodePackages.pyright
    bash

    # formatters and linters
    alejandra # nix
    black # python
    ruff # python
    deadnix # nix
    golangci-lint
    lua52Packages.luacheck
    pkgs.nodePackages.prettier
    shellcheck
    shfmt
    statix # nix
    sqlfluff
    tflint
  ];
in {
  imports = [
    nix-index-database.hmModules.nix-index
  ];

  home.stateVersion = "22.11";

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    sessionVariables.editor = "nvim";
    sessionVariables.shell = "/etc/profiles/per-user/${username}/bin/zsh";
  };

  home.packages =
    stable-packages
    ++ unstable-packages
    ++
    # fixme: you can add anything else that doesn't fit into the above two lists in here
    [
      # pkgs.some-package
      # pkgs.unstable.some-other-package
    ];

  # fixme: if you want to version your nvim config, add it to the root of this repo and uncomment the next line
  # home.file.".config/nvim/config.lua".source = ./nvim_config.lua;

  programs = {
    home-manager.enable = true;
    nix-index.enable = true;
    nix-index.enableZshIntegration = true;
    nix-index-database.comma.enable = true;

    starship.enable = true;
    starship.settings = {
      hostname.ssh_only = false;
      hostname.style = "bold green";
      username.show_always = true;
    };

    fzf.enable = true;
    fzf.enableZshIntegration = true;
    lsd.enable = true;
    lsd.enableAliases = true;
    zoxide.enable = true;
    zoxide.enableZshIntegration = true;
    direnv.enable = true;
    direnv.enableZshIntegration = true;
    direnv.nix-direnv.enable = true;
  };
}
