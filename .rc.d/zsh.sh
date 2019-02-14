# zsh only
[ -n "$ZSH_VERSION" ] || return 0

unsetopt BG_NICE
#Rebind HOME and END to do the decent thing:
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
case $TERM in (xterm*)
  bindkey '\eOH' beginning-of-line
  bindkey '\eOF' end-of-line
esac

#To discover what keycode is being sent, hit ^v
#and then the key you want to test.

#And DEL too, as well as PGDN and insert:
bindkey '\e[3~' delete-char
bindkey '\e[6~' end-of-history
bindkey '\e[2~' redisplay

#Now bind pgup to paste the last word of the last command,
bindkey '\e[5~' insert-last-word
