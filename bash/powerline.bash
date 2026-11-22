# Powerline prompt (Solarized, Nerd Font icons; config in ~/.config/powerline).
# Source it last from ~/.bashrc, after Omarchy's rc.
#
# Omarchy's bash init turns Starship on, so take its prompt hooks back first:
# it parks the earlier PROMPT_COMMAND in STARSHIP_PROMPT_COMMAND and times
# commands from PS0. Powerline goes last so its hook runs first and sees $?.
if [[ ${TERM:-} != dumb ]] && command -v powerline-daemon &>/dev/null; then
  if [[ ${PROMPT_COMMAND[0]-} == starship_precmd ]]; then
    PROMPT_COMMAND[0]=${STARSHIP_PROMPT_COMMAND-}
    unset STARSHIP_PROMPT_COMMAND
  fi
  PS0=${PS0//'${STARSHIP_START_TIME:$((STARSHIP_START_TIME="$(starship_preexec_ps0)",STARSHIP_PREEXEC_READY=0,0)):0}'/}

  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  powerline_bash=(/usr/lib/python3*/site-packages/powerline/bindings/bash/powerline.sh)
  [[ -r ${powerline_bash[0]} ]] && source "${powerline_bash[0]}"
  unset powerline_bash
fi
