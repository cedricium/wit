#
# The MIT License (MIT)
#
# Copyright (c) 2018 Cedric Amaya <@cedricium on GitHub>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.
#

main() {
  # use colors, but only if connected to a terminal, and that terminal
  # supports them.
  if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
  fi

  # check if `git` is installed, exit otherwise
  command -v git 2>&1 >/dev/null || {
    printf "${RED}Error: git is not installed!${NORMAL} Please install git first.\n"
    exit 1
  }

  # create env variable $WIT equal to '~/.wit'
  # ~/ should be the home directory, check what'll work on Windows
  if [ ! -n "$WIT" ]; then
    WIT=$HOME/.wit
  fi

  # ensure ~/.wit dir does not exist before `git clone`
  if [ -d "$WIT" ]; then
    printf "${YELLOW}wit already installed.${NORMAL}\n"
    printf "You'll need to remove $WIT if you want to re-install wit.\n"
    exit
  fi

  # Clone this repo into $WIT
  printf "\n${BLUE}Cloning wit...${NORMAL}\n"
  env git clone --depth=1 https://github.com/cedricium/wit.git "$WIT" || {
    printf "${RED}Error: git clone of wit repo failed.${NORMAL}\n"
    exit 1
  }

  # ensure $WIT/.git_templates exists, set as $WIT_TEMPLATES
  if [ -d "$WIT/.git_templates" ]; then
    WIT_TEMPLATES="$WIT/.git_templates"
  fi

  # set git init.templatedir to $WIT_TEMPLATES
  printf "\n${BLUE}Setting the git 'init.templatedir' config variable to:\n${NORMAL}${BOLD}  $WIT_TEMPLATES${NORMAL}\n"
  env git config --global init.templatedir "$WIT_TEMPLATES" || {
    printf "${RED}Error: git config of templatedir failed${NORMAL}\n"
    exit 1
  }

  printf "${GREEN}"
  echo ''
  echo ' _ _ __                _ __         _                       '
  echo '( | / /  _______ _  __(_/ /___ __  (_)__                    '
  echo '|/|/ _ \/ __/ -_| |/ / / __/ // / / (_-<                    '
  echo '  /_.__/_/  \__/|___/_/\__/\_, / /_/___/                    '
  echo '  __  __                  /___/      ___         _ __   _ _ '
  echo ' / /_/ / ___   ______ __ __/ / ___  / _/ _    __(_/ /_ ( | )'
  echo '/ __/ _ / -_) (_-/ _ / // / / / _ \/ _/ | |/|/ / / ___ |/|/ '
  echo '\__/_//_\__/ /___\___\_,_/_/  \___/_/   |__,__/_/\__(_)     '
  echo ''
  echo 'wit successfully installed, you are all set!'
  echo ''
  echo 'Using `git commit` in any newly-created git repos will auto'
  echo 'generate your first commit message - good luck!'
  echo ''
  printf "${NORMAL}"
}

main
