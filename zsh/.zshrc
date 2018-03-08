###
# @jonathano Thanks for the awesome config and theme
###

setopt prompt_subst
autoload -U promptinit && promptinit
autoload -U colors && colors
autoload -U add-zsh-hook

source ~/.zshtheme # Source the prompt theme
source ~/.antigen/antigen.zsh # Load antigen
antigen use oh-my-zsh # Add Oh My ZSH

# Some recommended plugins
antigen bundles <<EOBUNDLES
  git
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-completions
  denysdovhan/gitio-zsh
  voronkovich/gitignore.plugin.zsh
  chrissicool/zsh-256color
  node
  catimg
  nyan
  extract
  command-not-found
  heroku
  osx
EOBUNDLES

# Some Z hooks
antigen bundle rupa/z
add-zsh-hook precmd _z_precmd
function _z_precmd() {
  _z --add "$PWD"
}

antigen apply

# A simple calculator for the command line
function calc () { echo "$(($@))" }

# Base16 Colors
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
base16_bright

export ZSH="$HOME/.antigen" # Set the home ZSH directory

export CODEDIR="$HOME/dev" # Projects directory

alias s="subl $1" # shortcut for sublime text
alias pdir="cd $CODEDIR" # Cd to projects directory
alias nindex="node index.js" # Run index.js using nodejs
alias zshrc="source ~/.zshrc" # Update the zshrc
alias cls="clear" # Just cuz it's smaller, not cuz Windows
alias גב="cd" # When in hebrew mode, cd still works
alias בךקשר="clear" # When in hebrew mode, clear still works
alias ginit="git init && git add . && git commit -m \"🚀  Initial Commit\"" # Initialize an empty repository, add all of the files and commit them
alias easypush="git pull --rebase && npm version patch && git push && npm publish"

# zsh configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000
bindkey -v
zstyle :compinstall filename '/Users/yoavmmn/.zshrc'

setopt autocd extendedglob

# Ignore all duplicate entries in the history
setopt HIST_IGNORE_ALL_DUPS

# Also autocomplete aliases
setopt COMPLETE_ALIASES

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Autocomplete to aws-cli                                                                                              │
if [ -f '/usr/local/bin/aws_zsh_completer.sh' ] then source /usr/local/bin/aws_zsh_completer.sh; fi
