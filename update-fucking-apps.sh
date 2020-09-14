#!/usr/bin/env zsh

update_brew() {
  if type brew >/dev/null 2>&1; then
    echo -e "\033[33m"
    echo "==========================="
    echo "    Upadate Homebrew...    "
    echo "==========================="
    echo -e "\033[0m"
    brew update
    brew upgrade
    brew cleanup
  fi
}

update_brew_cask() {
  if type brew >/dev/null 2>&1; then
    echo -e "\033[33m"
    echo "================================"
    echo "    Upadate Homebrew Cask...    "
    echo "================================"
    echo -e "\033[0m"

    echo "Fech installed application list..."
    CASK_LIST=($(brew cask list))

    echo "Updating brew cask apps..."
    for APP_NAME in "${CASK_LIST[@]}"; do
      brew cask upgrade $APP_NAME
    done
    brew cleanup
  fi
}

update_gem() {
  if type gem >/dev/null 2>&1; then
    echo -e "\033[33m"
    echo "==========================="
    echo "    Upadate Ruby Gem...    "
    echo "==========================="
    echo -e "\033[0m"
    sudo gem update --system
    sudo gem update -V
    sudo gem cleanup -V
  fi
}

update_npm() {
  if type npm >/dev/null 2>&1; then
    echo -e "\033[33m"
    echo "==========================="
    echo "   Upadate Node's npm...   "
    echo "==========================="
    echo -e "\033[0m"
    npm install -g npm
    npm cache clean -f
  fi
}

update_mas() {
  if type mas >/dev/null 2>&1; then
    echo -e "\033[33m"
    echo "=============================="
    echo "   Upadate Mac App Store...   "
    echo "=============================="
    echo -e "\033[0m"
    mas upgrade
  fi
}

fix_issue() {
  #
  # Fix missing node 10 LTS
  #
  if ! [ -x "/usr/local/bin/node" ]; then
    echo "Installing and linking Node 10 LTS...."
    brew install node@10
    brew link node@10 --force --overwrite
    npm install -g npm
  fi
}

update_brew
update_brew_cask
update_gem
update_npm
update_mas
fix_issue
