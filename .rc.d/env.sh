# My development environment setup

# Path
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Pyenv && Pipenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# Don't use pyenv virtualenv hook cause performance issue
#eval "$(pyenv virtualenv-init -)"
# Shell completion for pipenv
eval "$(pipenv --completion)"
