#!/usr/bin/env zsh

# This ZSH plugin reads the text from the current buffer,
# allows the user to describe a change to command in natural
# language, and sends the request to an LLM to get a changed
# command

function do_completion() {
    local messages=$1
    local result=$(curl -s -X POST https://api.openai.com/v1/chat/completions \
        -H "Authorization: Bearer ${OPENAI_API_KEY:?}" \
        -H "Content-Type: application/json" \
        -d '{
            "model": "gpt-3.5-turbo",
            "temperature": 0,
            "max_tokens": 200,
            "messages": '"$messages"'
        }')
    echo "$result" | jq -r '.choices[0].message.content'
}

function create_completion() {
    local system_messages_file=~/bin/CmdLinePrompt.jsonl
    local prompt_file=/tmp/PROMPT_MSG
    local text_from_cmd=${BUFFER}

    echo -n "$text_from_cmd" > "$prompt_file"
    $EDITOR "$prompt_file" || { echo "Editor failed" >&2; return 1; }

    local content=$(<"$prompt_file")

    local messages=$(
        jq -s . $system_messages_file |
        jq --arg content "$content" '. + [{"role": "user", "content": $content}]')

    local completion=$(do_completion "$messages")

    rm -f "$prompt_file"

    BUFFER=$completion
    CURSOR=${#BUFFER}
}

zle -N create_completion
bindkey '^X' create_completion
