#!/bin/zsh

# This ZSH plugin reads the text from the current buffer,
# allows the user to describe a change to command in natural
# language, and sends the request to an LLM to get a changed
# command

function notify() {
    local title="$1"
    local message="$2"
    local timeout="${3:-8000}"   # default 8 seconds
    local severity="${4:-normal}"

    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS - using native AppleScript
        osascript -e "display notification \"$message\" with title \"$title\"" && sleep $((timeout/1000))
    else
        # Linux (and other systems)
        notify-send -t "$timeout" -u "$severity" "$title" "$message" 2>/dev/null || true
    fi
}

function process_command_completion() {
    local user_prompt_file=/tmp/USER_PROMPT
    local template_file=$XDG_CONFIG_HOME/llm_templates/cmd.yaml
    local current_command=${BUFFER}

    echo -n "$current_command" > "$user_prompt_file"
    $EDITOR "$user_prompt_file" 2>/dev/null || {
        echo "Failed to open editor: '$EDITOR'"
        notify "Error in [cmd-assistant] script" \
            "Failed to open editor: '$EDITOR'" 8000 critical
        return 1
    }

    local completion_result=$(with-spinner 'cat "$user_prompt_file" | llm -t "$template_file"')
    if [[ $completion_result == Error* ]]; then
        echo "LLM returned an error: ${completion_result}"
        notify "Error in [cmd-assistant] script" \
            "LLM returned an error: ${completion_result}" 8000 critical
        return 1
    fi

    print -nP "$PROMPT" >&2
    BUFFER=$completion_result
    CURSOR=${#BUFFER}
}

zle -N process_command_completion
bindkey '^X' process_command_completion

