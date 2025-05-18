#!/bin/zsh

# This ZSH plugin reads the text from the current buffer,
# allows the user to describe a change to command in natural
# language, and sends the request to an LLM to get a changed
# command

function format_multiline_output() {
    awk 'NR==1 {line=$0; next} {line=line "\\n" $0} END {print line}'
}

function get_openai_completion() {
    local messages="$1"
    echo "$messages" > "/tmp/completion_messages.json"

    local api_response=$(curl -s -X POST https://api.openai.com/v1/chat/completions \
        -H "Authorization: Bearer ${OPENAI_API_KEY:?}" \
        -H "Content-Type: application/json" \
        -d '{
            "model": "gpt-3.5-turbo",
            "temperature": 0,
            "max_tokens": 200,
            "messages": '"$messages"'
        }')
    echo "$api_response" > "/tmp/completion_response.json"

    echo "$api_response" |
        format_multiline_output |
        jq -r '.choices[0].message.content'
}

function get_claude_completion() {
    local messages="$1"
    echo "$messages" > "/tmp/completion_messages.json"

    local request_body=$(echo '{
        "model": "claude-3-5-sonnet-20241022",
        "max_tokens": 200,
        "system": '"$(echo "$messages" | jq ".[0].content")"',
        "messages": '"$(echo "$messages" | jq ".[1:]")"'
    }')
    echo "$request_body" > "/tmp/completion_request.json"

    local api_response=$(curl -s -X POST https://api.anthropic.com/v1/messages \
        -H "x-api-key: ${ANTHROPIC_API_KEY:?}" \
        -H "anthropic-version: 2023-06-01" \
        -H "Content-Type: application/json" \
        -d "$request_body")
    echo "$api_response" > "/tmp/completion_response.json"

    echo "$api_response" |
        format_multiline_output |
        jq -r '.content[0].text'
}

function process_command_completion() {
    local system_messages_file="$HOME/bin/CmdLinePrompt.jsonl"
    local user_prompt_file=/tmp/USER_PROMPT
    local current_command=${BUFFER}

    echo -n "$current_command" > "$user_prompt_file"
    $EDITOR "$user_prompt_file" 2>/dev/null || {
        notify-send -t 8000 -u critical \
            "Error in [cmd-assistant] script" \
            "Failed to open editor: '$EDITOR'" 2>/dev/null || true
        return 1
    }

    local user_content=$(<"$user_prompt_file" | sed ':a;N;$!ba;s/\n/\\\\n/g')

    local formatted_messages=$(
        jq -s . $system_messages_file |
        jq --arg content "$user_content" '. + [{"role": "user", "content": $content}]')

    local completion_result=$(get_claude_completion "$formatted_messages")

    BUFFER=$completion_result
    CURSOR=${#BUFFER}
}

zle -N get_openai_completion
zle -N get_claude_completion
zle -N process_command_completion
bindkey '^X' process_command_completion
