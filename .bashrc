if [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
fi

# For External or Custom Alias and Function
# Alias definitions.
  if [ -f ~/.bash_aliases.txt ]; then
      . ~/.bash_aliases.txt
  fi

# Function definitions.
if [ -f ~/.bash_functions.txt ]; then
    . ~/.bash_functions.txt
fi

# Prompt definitions.
if [ -f ~/.bash_prompt.txt ]; then
    . ~/.bash_prompt.txt
fi

if [ -d ~/bin ]; then
     export PATH="~/bin:$PATH"
  else
     echo "No Directory exist, Can not set the PATH for ~/bin. Non Fatal error"
fi

##################################################
# Stop Flash from tracking everything you do.    #
##################################################
## Brute force way to block all LSO cookies on Linux system with non-free Flash browser plugin
#for A in ~/.adobe ~/.macromedia ; do ( [ -d $A ] && rm -rf $A ; ln -s -f /dev/null $A ) ; done

xhost +local:root > /dev/null 2>&1

complete -cf sudo #autocomplete after 'sudo'
complete -cf man  #autocomplere after 'man' for man pages

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete
shopt -s nocaseglob

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth

# COLOURED MAN PAGES                     this is notes for video: http://www.youtube.com/watch?v=9BFaLAa428k
export LESS_TERMCAP_mb=$'\E[01;31m'    # begin blinking 
export LESS_TERMCAP_md=$'\E[01;31m'    # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # end mode
export LESS_TERMCAP_se=$'\E[0m'        # end standout-mode
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'        # end underline
export LESS_TERMCAP_us=$'\E[01;32m'    # begin underline          export MANPAGER="/usr/bin/most -s" # color using most

alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                       # confirm before overwriting something
alias df='df -h'                       # human-readable sizes
alias free='free -m'                   # show sizes in MB
alias np='vim PKGBUILD'                # Changed nano to vim

#                                      #usage: ex <file> #ex - archive extractor
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
} 

# PROMPT
PS1='[\u@\h \W]\$ ' 
BROWSER=/usr/bin/xdg-open
