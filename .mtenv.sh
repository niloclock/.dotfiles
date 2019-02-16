# Install dependency
echo ''
echo '> Dependency ------------------------------------------'
echo ''
sudo apt-get update
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
  libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
  xz-utils tk-dev libffi-dev liblzma-dev python-openssl

# common ######################################################
if [ ! -d $HOME/bin ]; then
  mkdir $HOME/bin
  echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
	source ~/.bashrc
fi

echo ''
echo '> Python ------------------------------------------'
echo ''
# pyenv
if [ -d ~/.pyenv ]; then
  echo ': Already installed'
else
  curl -L https://pyenv.run | bash
	source ~/.bashrc
fi
# pipenv
if type pipenv >/dev/null 2>&1; then
  pip install --user pipenv
fi

echo ''
echo '> Neovim ------------------------------------------'
echo ''
if type neovim >/dev/null 2>&1; then
  echo ': Already done'
else
  sudo apt install -y neovim
  # python version 3.6.0 설치
  # 설치 가능한 버전은 pyenv install --list 명령어로 확인할 수 있다.
  pyenv install 3.7.1
  pyenv install 2.7.15
  # virtualenv 설정 및 neovim python plugin 설치
  pyenv virtualenv 2.7.15 nvim-python2
  pyenv virtualenv 3.7.1 nvim-python3
  pyenv activate nvim-python2
  pip install neovim
  pyenv activate nvim-python3
  pip install neovim
  # The following is optional, and the neovim3 env is still active
  # This allows flake8 to be available to linter plugins regardless
  # of what env is currently active.  Repeat this pattern for other
  # packages that provide cli programs that are used in Neovim.
  pip install flake8
  ln -s `pyenv which flake8` $HOME/bin/flake8  # Assumes that $HOME/bin is in $PATH
fi

# # Zsh ################################
# # install Zsh itself
# sudo apt install -y zsh
# # install Oh my Zsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# # autojump
# sudo apt install -y autojump
# echo "plugins=(autojump)" >> ${ZDOTDIR:-$HOME}/.zshrc
# # zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# echo 'plugins=(zsh-autosuggestions)' >> $HOME/.zshrc

# Rust #######################################

