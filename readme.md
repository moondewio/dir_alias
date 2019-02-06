<h1 align="center">dir_alias</h1>
<p align="center">Directory based aliases</p>

## Usage

Define an `.aliasfile` with the bash aliases for the directory.

```sh
alias foo='echo "foo"'
alias bar="echo 'bar'"
```

**IMPORTANT**: the file should only contain alias definitions, one per line.

## Installation

Using [antigen](http://antigen.sharats.me/),
[antibody](http://getantibody.github.io/), or
[some other zsh plugin manager](https://github.com/unixorn/awesome-zsh-plugins#installation):

```
$ antigen bundle moondewio/dir_alias
```

```sh
$ antibody bundle moondewio/dir_alias >> ~/.zsh_plugins.sh
```

Or by clonning the repo and sourcing the file:

```sh
git clone https://github.com/moondewio/dir_alias.git
echo "source ~/path/to/dir_alias/dir_alias.plugin.zsh" > ~/.zshrc
```

## Acknowledgements

Inspired on
[carlosV2/bash-aliases-per-directory](https://github.com/carlosV2/bash-aliases-per-directory).
