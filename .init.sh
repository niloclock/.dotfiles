# dependency 설치
sudo apt-get update
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev

# pyenv git clone
if [ ! -d ~/.pyenv ]; then
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
	echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
	echo 'eval "$(pyenv init -)"' >> ~/.bashrc
	source ~/.bashrc
fi

# python version 3.6.0 설치
# 설치 가능한 버전은 pyenv install --list 명령어로 확인할 수 있다.
pyenv install 3.6.0
# pyenv-virtualenv plugin 설치
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
# virtualenv 설정 및 neovim python plugin 설치
pyenv virtualenv 2.7.15 neovim2
pyenv virtualenv 3.6.0 neovim3
pyenv activate neovim2
pip install neovim
pyenv activate neovim3
pip install neovim

# The following is optional, and the neovim3 env is still active
# This allows flake8 to be available to linter plugins regardless
# of what env is currently active.  Repeat this pattern for other
# packages that provide cli programs that are used in Neovim.
pip install flake8
ln -s `pyenv which flake8` ~/bin/flake8  # Assumes that $HOME/bin is in $PATH

# Zsh ################################
# install Zsh itself
sudo apt install -y zsh
# install Oh my Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# autojump
sudo apt install -y autojump
echo "plugins=(autojump)" >> ${ZDOTDIR:-$HOME}/.zshrc
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo 'plugins=(zsh-autosuggestions)' >> $HOME/.zshrc
