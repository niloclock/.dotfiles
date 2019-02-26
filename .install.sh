set -o errexit
set -o nounset

# dependency #################################################
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
  libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
  xz-utils tk-dev libffi-dev liblzma-dev \
  python-dev python-pip python3-dev python3-pip python-openssl

# yadm #######################################################
if type yadm >/dev/null 2>&1; then
  echo 'yadm) Already installed'
else
  echo 'yadm) Install'
  sudo apt-get install -y yadm
fi


# common ######################################################
if [ ! -d $HOME/bin ]; then
  mkdir $HOME/bin
  #echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc => Moved in '.rc.d/env.sh'
  source ~/.bashrc
fi


# python ######################################################
# pyenv
if type pyenv >/dev/null 2>&1; then
  echo 'pyenv) Already installed'
else
  echo 'pyenv) Install'
  curl -L https://pyenv.run | bash
  eval "$(pyenv init -)"
fi
# pipenv
if type pipenv >/dev/null 2>&1; then
  echo 'pipenv) Already installed'
else
  echo 'pipenv) Install'
  pip install --user pipenv
fi
# pytest
if type pytest >/dev/null 2>&1; then
  echo 'pytest) Already installed'
else
  echo 'pytest) Install'
  pip install --user pytest
fi


# neovim ######################################################
if type nvim >/dev/null 2>&1; then
  echo 'neovim) Already installed'
else
  echo 'neovim) Install'
  sudo add-apt-repository -y ppa:neovim-ppa/stable
  sudo apt-get update
  sudo apt-get install -y neovim
  # python version 3.6.0 설치
  # 설치 가능한 버전은 pyenv install --list 명령어로 확인할 수 있다.
  pyenv install 3.7.2
  pyenv install 2.7.15
  # virtualenv 설정 및 neovim python plugin 설치
  pyenv virtualenv 2.7.15 nvim-python2
  pyenv virtualenv 3.7.2 nvim-python3
  pyenv shell nvim-python2
  pip install neovim
  pyenv shell nvim-python3
  pip install neovim
  # The following is optional, and the neovim3 env is still active
  # This allows flake8 to be available to linter plugins regardless
  # of what env is currently active.  Repeat this pattern for other
  # packages that provide cli programs that are used in Neovim.
  pip install flake8
  ln -s `pyenv which flake8` $HOME/bin/flake8  # Assumes that $HOME/bin is in $PATH
  pyenv shell system
fi


# Zsh ################################
if false; then # disable
  # install Zsh itself
  sudo apt-get install -y zsh fonts-powerline
  # install Oh my Zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  # autojump
  sudo apt install -y autojump
  echo "plugins=(autojump)" >> ${ZDOTDIR:-$HOME}/.zshrc
  # zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  echo 'plugins=(zsh-autosuggestions)' >> $HOME/.zshrc
fi

# Rust #######################################
# TODO

