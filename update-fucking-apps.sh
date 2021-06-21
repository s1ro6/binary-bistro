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
  fi
}

update_brew_cask() {
  if type brew >/dev/null 2>&1; then
    echo -e "\033[33m"
    echo "================================"
    echo "    Upadate Homebrew Cask...    "
    echo "================================"
    echo -e "\033[0m"

    echo "Loading brew cask app list..."
    app_list=($(brew list --cask))
    for app in "${app_list[@]}"; do
      echo "Updating apps: ${app}..."
      brew upgrade --cask $app
    done
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

remove_caches() {
  brew cleanup --prune=all
  npm cache clean -f
  sudo gem cleanup -V
}

fix_issue() {
  #
  # Fix missing node 12 LTS
  #
  if ! [ -x "/usr/local/bin/node" ]; then
    echo "Installing and linking Node 12 LTS...."
    brew install node@12
    brew link node@12 --force --overwrite
    npm install -g npm
  fi
}

update_brew
update_brew_cask
update_gem
update_npm
update_mas
remove_caches
fix_issue
