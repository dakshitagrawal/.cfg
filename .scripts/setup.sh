cd $HOME

apt install -y curl

apt-get install -y tmux
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf

git clone --bare https://github.com/dakshitagrawal97/.cfg.git $HOME/.cfg

function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config."
else
    echo "Backing up pre-existing dot files."
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi

config checkout
config config status.showUntrackedFiles no

apt install -y zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
config checkout -- .zshrc

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

chmod u+x $HOME/nvim.appimage && $HOME/nvim.appimage
if [$? = 0 ]; then
    echo "Installed nvim"
else
    $HOME/nvim.appimage --appimage-extract
    echo "alias nvim='$HOME/squashfs-root/usr/bin/nvim'" >> $HOME/.zshrc
fi

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

pip install pynvim
pip install flake8-black
pip install isort

if [ ! -d "$HOME/miniconda3" ]; then
    curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh
    rm Miniconda3-latest-Linux-x86_64.sh
fi

