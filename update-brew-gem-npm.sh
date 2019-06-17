#!/usr/bin/env bash

echo
echo "==========================="
echo "    Upadate Homebrew...    "
echo "==========================="
echo
brew update
brew upgrade
brew cask upgrade
brew cleanup

echo
echo "==========================="
echo "    Upadate Ruby Gem...    "
echo "==========================="
echo
sudo gem update --system
sudo gem update -V
sudo gem cleanup -V

echo
echo "==========================="
echo "   Upadate Node's npm...   "
echo "==========================="
echo
npm install -g npm
npm cache clean -f
