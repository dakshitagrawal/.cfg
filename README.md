# My Ubuntu Configuration
This repository contains my current linux environment configuration. It facilitates a quick and easy setup on other Ubuntu systems.

## Prerequisites

* Make sure the terminal supports 256 coloring (like `xterm-256color`).

## Setup

1. Run this command for setting up the environment:

```bash
apt install -y curl && \
curl https://raw.githubusercontent.com/dakshitagrawal97/.cfg/master/setup.sh?token=AFCJ5OCL4DHP6HZDQMLX3Q27HDIXU -o setup.sh && \
bash setup.sh
```

2. Type in your github account credentials.
3. Press `ENTER` when asked if you want to change your default shell to zsh.
4. Type `exit` to exit zsh and continue setup.
5. Once installation is done, type `zsh` followed by `nvim`.
6. Press `ENTER` to open up the NVIM introduction page.
7. Type `:PlugInstall` and keep pressing `ENTER` until the installer prompt at the bottom closes.
8. Type `:q` to exit installation progress window.
8. Type `:UpdateRemotePlugins` and press `ENTER` to continue.
9. Exit `nvim` by typing `:q`

## Resources

The following resources were used to setup this repository:

1. [Atlassian's dotfile tutorial](https://www.atlassian.com/git/tutorials/dotfiles)

