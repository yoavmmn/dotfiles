###
# @jonathano Thanks for the awesome config
###

setopt prompt_subst
autoload -U promptinit && promptinit
autoload -U colors && colors
autoload -U add-zsh-hook

source ~/.antigen/antigen.zsh # Load antigen
antigen use oh-my-zsh # Add Oh My ZSH

# Some recommended plugins
antigen bundles <<EOBUNDLES
  zsh-users/zsh-syntax-highlighting
  voronkovich/gitignore.plugin.zsh
  zsh-users/zsh-completions
  chrissicool/zsh-256color
  denysdovhan/gitio-zsh
  command-not-found
  extract
  catimg
  heroku
  node
  nyan
  git
  osx
EOBUNDLES

# Import my changes
for file in ~/.zsh_local/*.zsh; do
  if [[ -e $file ]]; then
    source $file
  fi
done

antigen bundle yardnsm/blox-zsh-theme

antigen apply

# Base16 Colors
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
base16_bright

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

# Autocomplete to aws-cli
if [ -f '/usr/local/bin/aws_zsh_completer.sh' ]
  then
    source "/usr/local/bin/aws_zsh_completer.sh"
fi