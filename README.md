# wit · [![GitHub](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/cedricium/wit/blob/master/LICENSE.md) [![GitHub](https://img.shields.io/badge/share-twitter-76abec.svg)](https://twitter.com/intent/tweet?text=Stop%20using%20%22initial%20commit%22%20and%20have%20some%20fun%20with%20your%20first%20commit%20messages!%20%23wit%0A%0Ahttps%3A//github.com/cedricium/wit)

**An initial commit message generator as a git hook.**

<img src="res/raccoon.jpg" align="right" height="350px">

The “initial commit” message as a first commit in many repos is quite boring (personally speaking
of course). Since that initial commit message conveys very little valuable information to begin
with, developers should have a chance to have some fun with that first message. Thinking of a
clever message can be hard however, so that’s where wit comes in.

With a collection of funny, clever, and witty messages (brought to you
by the many contributors of [ngerakines/commitment](https://github.com/ngerakines/commitment)),
wit automatically fills out your first commit message in any newly-created git repository.

Super cute raccoon illustration by Lauren Pettapiece, https://www.laurenpettapiece.com/


## How Does it Work?

The bread and butter of wit lies in the `.git_templates/hooks/prepare-commit-msg` file. This is a
standard [git hook](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks), whose function
is described as:

> "The prepare-commit-msg hook is run before the commit message editor is fired up but after
> the default message is created. It lets you edit the default message before the commit author sees it."

In order to achieve witty first commit messages, the `prepare-commit-msg` hook first checks to ensure
there are zero (0) commits throughout the entire git repo. If that’s true, then the hook simply
replaces the first line of the commit template message (either the default git message or whatever 
is set under the git `commit.template` config variable) with a random line from this list of messages.


## Getting Started

### Prerequisites

> Note: wit works best on Linux and macOS.

* `curl` or `wget` should be installed
* `git` should be installed

### Installation

Wit is installed by running one of the following commands in your terminal. You can install this via
the command-line with either `curl` or `wget`.

**via curl**

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/cedricium/wit/master/scripts/install.sh)"
```

**via wget**

```sh
sh -c "$(wget https://raw.githubusercontent.com/cedricium/wit/master/scripts/install.sh -O -)"
```


## Using wit

### Adding / Removing Commit Messages

The list of commit messages used by wit can be found at: `$HOME/.wit/res/commit_messages.txt`
Feel free to add or remove any lines you see fit, ensuring there are no empty lines in the file.

### Uninstalling wit

Although we're sad to see you go, uninstalling wit is a straight-forward process. Just run:

```sh
$ sh ~/.wit/scripts/uninstall.sh
```

Alternatively, you can wrap the above code in a function and add it to the end of your shell's
run commands file (bash: `.bashrc` or `.bash_profile`, zsh: `.zshrc`):

```sh
function uninstall_wit() {
  sh ~/.wit/scripts/uninstall.sh
}
```

Then you can use `uninstall_wit` from the command-line to initiate the uninstall process.

## Contributing

Your contributions are always welcome! See an issue you want to tackle or have an idea for a feature
you'd like implemented? Just open a pull-request with a short explanation of the changes and I'd be 
happy to review it.

Refer to this project's [contributing guidelines](CONTRIBUTING.md) to better understand what's
expected as a contributing member.


## License

Wit released under the [MIT License](LICENSE.md).
