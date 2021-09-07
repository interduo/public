#!/bin/bash
REMOTE_NAME='interduo'
IGNORED_REMOTES_FILE='./ignored_remotes'
ACTIVE_BRANCHES_FILE='./activebraches'

git fetch ${REMOTE_NAME}
git checkout ${REMOTE_NAME}

git remote | grep -v ${REMOTE_NAME} > ${IGNORED_REMOTES_FILE}
gh pr list --author @me | cut -f3 | cut -d":" -f2 > ${ACTIVE_BRANCHES_FILE}

BRANCHES=`git branch -r | grep -v -f ${IGNORED_REMOTES_FILE} | grep -v -f ${ACTIVE_BRANCHES_FILE} | cut -d'/' -f2-`

for i in ${BRANCHES}
do 
	git push ${REMOTE_NAME} --delete $i
done
