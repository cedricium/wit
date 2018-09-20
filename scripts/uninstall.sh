#
# Copyright (c) 2018, Cedric Amaya <@cedricium on GitHub>
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
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    NORMAL=""
  fi

  read -r -p "Are you sure you want to remove wit? [y/N] " confirmation
  if [ "$confirmation" != y ] && [ "$confirmation" != Y ]; then
    printf "${GREEN}Uninstall cancelled.${NORMAL}\n"
    exit
  fi

  printf "\n${BLUE}Removing ~/.wit...${NORMAL}\n"
  if [ -d ~/.wit ]; then
    rm -rf ~/.wit
    # ensure ~/.wit dir has been removed
    if [ ! -d ~/.wit ]; then
      printf "  ✔ successfully removed ~/.wit\n"
    else
      printf "${RED}  Error: removal of ~/.wit${NORMAL}\n"
      exit 1
    fi
  else
    printf "${YELLOW}~/.wit does not exist. Did you remove it?${NORMAL}\n"
  fi

  printf "\n${BLUE}Resetting git 'init.templatedir' config var...${NORMAL}\n"
  if [ -n $(git config --global --get init.templatedir) ]; then
    env git config --global --unset init.templatedir
    # ensure 'init.templatedir' has been unset
    if [ ! $(git config --global --get init.templatedir) ]; then
      printf "  ✔ successfully reset 'init.templatedir' config var${NORMAL}\n"
    else
      printf "${RED}  Error: unset of git 'init.templatedir' var${NORMAL}\n"
      exit 1
    fi
  fi

  printf "\n${GREEN}Thanks for using wit. It has been uninstalled.${NORMAL}\n"
}

main
