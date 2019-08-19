#!/usr/bin/env bash

echo -e "\033[33m"
echo "==========================="
echo "    Upadate Homebrew...    "
echo "==========================="
echo -e "\033[0m"
brew update --verbose
brew upgrade --verbose
brew cask upgrade --verbose
brew cleanup --verbose

echo -e "\033[33m"
echo "==========================="
echo "    Upadate Ruby Gem...    "
echo "==========================="
echo -e "\033[0m"
sudo gem update --system
sudo gem update -V
sudo gem cleanup -V

echo -e "\033[33m"
echo "==========================="
echo "   Upadate Node's npm...   "
echo "==========================="
echo -e "\033[0m"
npm install -g npm
npm cache clean -f

#
# Fix missing node 10 LTS
#
if ! [ -x "/usr/local/bin/node" ]; then
    echo "Installing and linking Node 10 LTS...."
    brew install node@10
    brew link node@10 --force --overwrite
fi
