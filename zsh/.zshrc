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
  git
  osx
EOBUNDLES

# Import my changes
for file in ~/.zsh_local/*.zsh; do
  if [[ -e $file ]]; then
    source $file
  fi
done

# import zsh-autocomplete
source $HOME/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

antigen bundle yardnsm/blox-zsh-theme

antigen apply

# Base16 Colors
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# zsh configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000
bindkey -v
zstyle ':autocomplete:*' min-input 2
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

# Android studio and Ract Native
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:/usr/local/sbin
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# key bindings
bindkey "^[f" forward-word
bindkey "^[b" backward-word
bindkey "^[end" end-of-line
bindkey "^[begin" beginning-of-line
