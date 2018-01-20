#!/bin/bash

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

update_file() {
    git remote add origin-pages https://${GITHUB_TOKEN}@github.com/hacking-thursday/yuan-data.git > /dev/null 2>&1
    git push --quiet --set-upstream origin master
}

echo ${GITHUB_TOKEN}

git status | grep autogen/data.json

RET=$?

if [[ $RET == 0 ]]; then
    setup_git
    git add autogen/data.json
    git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
    update_file
fi
