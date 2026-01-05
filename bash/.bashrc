#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export PATH="$HOME/.local/bin:$PATH"

# Z.AI Alias for Claude Code
alias z.ai='ANTHROPIC_BASE_URL=https://api.z.ai/api/anthropic ANTHROPIC_AUTH_TOKEN=e81d209ce9ff493daaeb6f747de0b44b.u6QnO4jSwaZGaQ6S ANTHROPIC_DEFAULT_HAIKU_MODEL=glm-4.5-air ANTHROPIC_DEFAULT_SONNET_MODEL=glm-4.6 ANTHROPIC_DEFAULT_OPUS_MODEL=glm-4.6 claude'

# === Claude Official (Anthropic) ===
claude() {
    ANTHROPIC_DEFAULT_HAIKU_MODEL=claude-3-5-haiku-20241022 ANTHROPIC_DEFAULT_SONNET_MODEL=claude-sonnet-4-5-20250514 ANTHROPIC_DEFAULT_OPUS_MODEL=claude-opus-4-5-20250514 command claude "$@"
}

# === OpenCode Aliases ===
alias oc='opencode'
alias ocrun='opencode run'
alias ocfree='opencode -m opencode/glm-4.7-free'
alias ocglm='opencode -m opencode/glm-4.7-free'
alias occ='opencode --continue'
alias ochelp='cat ~/GUIA-OPENCODE.md'
