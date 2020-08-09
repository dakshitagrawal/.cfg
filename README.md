# My Ubuntu Configuration
This repository contains my current linux environment configuration. It facilitates a quick and easy setup on other Ubuntu systems. This is how it looks after setup:

![](./.cfg/assets/zsh.png)

![](./.cfg/assets/nvim1.png)

## I. Prerequisites

1. Make sure the terminal supports 256 colors so that `zsh` shows proper colors. This can be done by running the following command on your terminal:

    ```bash
    tput colors
    ```
    The output should be `256`.

2. Set `$TERM=xterm-256color`.

## II. Setup

This will create a backup of your current configs and install the following:
* [curl](https://curl.haxx.se/)
* [tmux](https://github.com/tmux/tmux/wiki)
* [oh-my-zsh](https://ohmyz.sh/)
* [nvim](https://neovim.io/)
* [miniconda](https://docs.conda.io/en/latest/miniconda.html)

It will also override the configs of the following after taking a backup of the current configs:
* ssh
* [terminator](https://terminator-gtk3.readthedocs.io/en/latest/)

### Start Installation
1. Run this command to start environment setup:

```bash
apt install -y curl && \
curl -O https://raw.githubusercontent.com/dakshitagrawal97/.cfg/master/.scripts/setup.sh && \
bash setup.sh
```

### During Installation

2. Type in your github account credentials if prompted.
3. Press `ENTER` when asked if you want to change your default shell to zsh.
4. Type `exit` to exit zsh and continue setup.

If you do not have miniconda at `$HOME/miniconda`, it will get installed:

5. Press `ENTER` to start `miniconda` installation.
6. Press `d` to scroll down and type `yes` to accept the license.
7. Press `ENTER` to confirm location of install as `$HOME/miniconda3`.
8. Type `no` or press `ENTER` to not initialize Miniconda3 by running `conda init`.

### After Installation

9. Type `zsh` to start zsh.
10. Type `nvim` and press `ENTER` to open up the NVIM introduction page.
11. Type `:PlugInstall` and keep pressing `ENTER` until the installer prompt at the bottom closes.
12. Type `:q` and press `ENTER` to exit installation progress window.
13. Type `:UpdateRemotePlugins` and press `ENTER` to continue.
14. Type `:q` to exit `nvim`.
15. Type `conda env create -f $HOME/conda.yml` to recreate conda environment.

## III. Optional Scripts
* Install [terminator](https://terminator-gtk3.readthedocs.io/en/latest/) by running `bash $HOME/.scripts/install_terminator.sh`.
* Clean up redundant and older versions of Snap applications by running `bash $HOME/.scripts/snap_clean.sh`.


## IV. Resources

The following resources were helpful in setting up this repository:

* [Atlassian's dotfile tutorial](https://www.atlassian.com/git/tutorials/dotfiles)

The following resources were helpful in customizing my dotfiles.
* [A Complete Guide to Setting up Neovim for Python Development on Linux](https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/)
* GitHub READMEs of various plugins
* TMUX configuration taken from this [GitHub repository](https://github.com/gpakosz/.tmux)
* [Free Up Space on Ubuntu](https://itsfoss.com/free-up-space-ubuntu-linux/)
* [Making neovim default editor for Nautilus](https://askubuntu.com/questions/97683/how-can-i-change-the-default-text-editor-from-gedit-to-vim)
