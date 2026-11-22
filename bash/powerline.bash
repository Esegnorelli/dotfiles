# Prompt: the current directory as a blue Powerline segment and "-> " on the
# left (red after a failed command), the git branch as a Powerline segment on
# the right edge of the same line (theme "prompt" in ~/.config/powerline).
# Source it last from ~/.bashrc, after Omarchy's rc.
#
# Powerline's bash binding only renders the left side, so this hook asks the
# daemon for both sides and draws the right one at the last columns, then
# returns the cursor (DECSC/DECRC) so it takes no room in the prompt.
#
# Omarchy's bash init turns Starship on, so take its prompt hooks back first:
# it parks the earlier PROMPT_COMMAND in STARSHIP_PROMPT_COMMAND and times
# commands from PS0.
if [[ ${TERM:-} != dumb ]] && command -v powerline-daemon &>/dev/null; then
  if [[ ${PROMPT_COMMAND[0]-} == starship_precmd ]]; then
    PROMPT_COMMAND[0]=${STARSHIP_PROMPT_COMMAND-}
    unset STARSHIP_PROMPT_COMMAND
  fi
  PS0=${PS0//'${STARSHIP_START_TIME:$((STARSHIP_START_TIME="$(starship_preexec_ps0)",STARSHIP_PREEXEC_READY=0,0)):0}'/}

  powerline-daemon -q

  _powerline_arrow_prompt() {
    local status=$? right plain
    right=$(powerline shell right --width="${COLUMNS:-80}" 2>/dev/null)
    PS1=$(powerline shell left -r.bash --renderer-arg="client_id=$$" 2>/dev/null)
    if [[ -n $right ]]; then
      plain=$(sed 's/\x1b\[[0-9;]*m//g' <<<"$right")
      # PS1 is expanded again at display time; a branch named $(...) must stay text.
      right=${right//\\/\\\\}
      right=${right//\$/\\\$}
      right=${right//\`/\\\`}
      # To the right margin, then back over the segment: right even before
      # checkwinsize has updated $COLUMNS for a new or resized window.
      PS1="\[\e7\e[999C\e[$((${#plain} - 1))D$right\e8\]$PS1"
    fi
    if ((status)); then
      PS1+='\[\e[31m\]->\[\e[0m\] '
    else
      PS1+='-> '
    fi
    return $status
  }

  # First in PROMPT_COMMAND, so it sees the exit status of the command.
  if [[ ${PROMPT_COMMAND[0]} != *_powerline_arrow_prompt* ]]; then
    PROMPT_COMMAND[0]="_powerline_arrow_prompt${PROMPT_COMMAND[0]:+;${PROMPT_COMMAND[0]}}"
  fi
fi
