#!/usr/bin/python

import glob, os, subprocess
from typing import Iterable, List

def get_git_commits(path: str) -> List[str]:
    os.chdir(path)
    try:
        return subprocess.check_output(['git', 'log', '--since=8.day', '--pretty=%h %<(15)%an %<(16)%ah %s']).decode().splitlines()
    except subprocess.CalledProcessError:
        return []

def get_git_repos(filename: str) -> Iterable[str]:
    with open(filename) as f:
        lines = f.read().splitlines()
    return (root[:-5]
            for path in lines
            for root in glob.glob(f"{path}/*/.git", recursive=True))

def summarize(repos: Iterable[str]) -> Iterable[str]:
    for repo in repos:
        commits = get_git_commits(repo)
        if not commits: continue
        yield repo
        yield from commits
        yield ""

def main():
    filename = os.path.join(os.path.dirname(__file__), "dirs.txt")
    print(*summarize(get_git_repos(filename)), sep='\n')

if __name__ == "__main__":
    main()
