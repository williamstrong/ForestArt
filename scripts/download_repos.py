#! /usr/bin/env python3

import os
import sys

from git import Repo
from git.util import assure_directory_exists

def repo_url(github_url, repo):
    extension = ".git"
    return github_url + repo + extension


def clone_modules(github_url, repo_list, base_dir):
    for repo in repo_list:
        directory = os.path.join(base_dir, repo)
        print(directory)
        if os.path.isdir(directory):
            print('The path:', directory, 'already exists.')
        else:
            repo = Repo.clone_from(repo_url(github_url, repo), directory)

if __name__ == '__main__':
    print("Downloading repos...")
    github_url = "https://github.com/williamstrong/"
    repo_list = [
            "ForestArtWebUI",
            "ForestArtCommunication",
            "ForestArtServer",
            "ForestArtImage"
            ]
    tmp_dir = sys.argv[1]

    clone_modules(github_url, repo_list, tmp_dir)

