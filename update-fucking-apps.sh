#!/bin/bash

update_brew() {
  if type brew >/dev/null 2>&1; then
    echo -e "\033[33m"
    echo "==========================="
    echo "    Upadate Homebrew...    "
    echo "==========================="
    echo -e "\033[0m"

    brew update
    brew upgrade --greedy
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

remove_caches() {
  brew cleanup --prune=all
  npm cache clean -f
}

main() {
  update_brew
  update_npm
  remove_caches
}

main
