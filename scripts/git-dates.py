#!/usr/bin/env python3
"""Ставит каждой заметке время её последнего коммита.

Свежий checkout в CI даёт всем файлам одно время, и карта сайта говорит, что каждая страница
изменилась в день деплоя. Движок берёт <lastmod> из времени файла (или из `updated` заметки).
Нужна полная история: actions/checkout с fetch-depth: 0.

    python3 scripts/git-dates.py content
"""
import os
import subprocess
import sys

root = os.getcwd()
targets = sys.argv[1:] or ["content"]


def git(*args):
    return subprocess.run(["git", "-c", "core.quotePath=false", "-C", root, *args], capture_output=True, text=True)


if git("rev-parse", "--is-shallow-repository").stdout.strip() == "true":
    print("git-dates: shallow checkout, set fetch-depth: 0 to date pages by their commits")
    raise SystemExit(0)

count = 0
for target in targets:
    log = git("log", "--format=@%ct", "--name-only", "--", target)
    if log.returncode != 0:
        continue
    seen, stamp = set(), None
    for line in log.stdout.splitlines():
        if line.startswith("@"):
            stamp = int(line[1:])
            continue
        if not line or line in seen or stamp is None:
            continue
        seen.add(line)
        path = os.path.join(root, line)
        if os.path.isfile(path):
            os.utime(path, (stamp, stamp))
            count += 1
print(f"git-dates: {count} files dated by their last commit")
