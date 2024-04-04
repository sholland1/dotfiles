#!/usr/bin/env python3

import json, os, sys
from openai import OpenAI

def do_completion(client: OpenAI, messages: list[str]) -> str:
    result = client.chat.completions.create(
        model="gpt-3.5-turbo",
        temperature=0,
        max_tokens=200,
        messages=messages,
    )

    return result.choices[0].message.content

def main():
    client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

    system_messages_file = os.path.expanduser(sys.argv[1])
    prompt_file = sys.argv[2]

    if not system_messages_file or not prompt_file:
        print("Usage: ai_completion_from_file.py <system_messages_file.jsonl> <prompt_file>")
        return 1

    with open(system_messages_file) as f:
        messages = [json.loads(line) for line in f.readlines()]

    with open(prompt_file) as f:
        prompt = f.read()

    messages.append({"role": "user", "content": prompt})

    command = do_completion(client, messages)
    print(command)
    return 0

if __name__ == "__main__":
    main()
