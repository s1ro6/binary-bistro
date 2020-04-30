#!/usr/bin/env zsh

function updateBrew() {
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

function updateBrewCask() {
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
    fi
}

function updateGem() {
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

function updateNpm() {
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

function updateMas() {
    if type mas >/dev/null 2>&1; then
        echo -e "\033[33m"
        echo "=============================="
        echo "   Upadate Mac App Store...   "
        echo "=============================="
        echo -e "\033[0m"
        mas upgrade
    fi
}

function fixIssue() {
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

updateBrew
updateBrewCask
updateGem
updateNpm
updateMas
fixIssue
