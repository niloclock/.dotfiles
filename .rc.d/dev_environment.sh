# My development environment setup

# My path
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Environment variables for pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

