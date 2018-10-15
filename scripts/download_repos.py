#! /usr/bin/env python3

import os
import sys

from git import Repo
from git.util import assure_directory_exists

print(os.getcwd())
print(sys.argv)

github_url = "https://github.com/williamstrong/"
repo_list = [
        "ForestArtWebUI",
        "ForestArtCommunication",
        "ForestArtServer",
        "ForestArtImage"
        ]

def repo_url(github_url, repo):
    extension = ".git"
    return github_url + repo + extension

tmp_dir = sys.argv[1]

for repo in repo_list:
    directory = os.path.join(tmp_dir, repo)
    print(directory)
    if os.path.isdir(directory):
        print('The path:', directory, 'already exists.')
    else:
        repo = Repo.clone_from(repo_url(github_url, repo), directory)

