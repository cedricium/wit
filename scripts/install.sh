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
  # check if `git` is installed, exit otherwise
  command -v git 2>&1 >/dev/null || {
    printf "Error: git is not installed! Please install git first\n"
    exit 1
  }

  # create env variable $WIT equal to '~/.wit'
  # ~/ should be the home directory, check what'll work on Windows
  if [ ! -n "$WIT" ]; then
    WIT=$HOME/.wit
  fi

  # ensure ~/.wit dir does not exist before `git clone`
  if [ -d "$WIT" ]; then
    printf "Looks like you already have wit installed.\n"
    printf "You'll need to remove $WIT if you want to re-install.\n"
    exit
  fi

  # Clone this repo into $WIT
  printf "Cloning wit...\n"
  env git clone --depth=1 https://github.com/cedricium/wit.git "$WIT" || {
    echo "Error: git clone of wit repo failed"
    exit 1
  }

  # ensure $WIT/.git_templates exists, set as $WIT_TEMPLATES
  if [ -d "$WIT/.git_templates" ]; then
    WIT_TEMPLATES="$WIT/.git_templates"
  fi

  # set git init.templatedir to $WIT_TEMPLATES
  printf "Setting the git 'init.templatedir' config variable to:\n  $WIT_TEMPLATES\n"
  env git config --global init.templatedir "$WIT_TEMPLATES" || {
    printf "Error: git config of templatedir failed"
    exit 1
  }

  # print wit is installed and ready-to-go
  echo ""
  echo "             __________ "
  echo "   ___      ____(_)_  /_"
  echo "   __ | /| / /_  /_  __/"
  echo "   __ |/ |/ /_  / / /_  "
  echo "   ____/|__/ /_/  \__/  "
  echo "                   ....is now installed!"
  echo ""
}

main
