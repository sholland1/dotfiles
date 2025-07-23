#!/bin/zsh

# This ZSH plugin reads the text from the current buffer,
# allows the user to describe a change to command in natural
# language, and sends the request to an LLM to get a changed
# command

function process_command_completion() {
    local user_prompt_file=/tmp/USER_PROMPT
    local template_file=$XDG_CONFIG_HOME/llm_templates/cmd.yaml
    local current_command=${BUFFER}

    echo -n "$current_command" > "$user_prompt_file"
    $EDITOR "$user_prompt_file" 2>/dev/null || {
        notify-send -t 8000 -u critical \
            "Error in [cmd-assistant] script" \
            "Failed to open editor: '$EDITOR'" 2>/dev/null || true
        return 1
    }

    local completion_result=$(cat "$user_prompt_file" | llm -t "$template_file" 2>&1)
    if [[ $completion_result == Error* ]]; then
        notify-send -t 8000 -u critical \
            "Error in [cmd-assistant] script" \
            "LLM returned an error: ${completion_result}" 2>/dev/null || true
        return 1
    fi

    BUFFER=$completion_result
    CURSOR=${#BUFFER}
}

zle -N process_command_completion
bindkey '^X' process_command_completion

