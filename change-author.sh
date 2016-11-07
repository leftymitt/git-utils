#! /bin/bash
set -eu

################################################################################
# change the email and committer name in git history. run from the base of the 
# repository. Variables: 
#
#   OLD_EMAIL = the address to be changed
#   OLD_AUTHOR = the address to be changed
#   NEW_EMAIL = address to change it to
#   NEW_AUTHOR = the name of the author associalted with NEW_EMAIL
#
################################################################################

export OLD_AUTHOR="$1"
export OLD_EMAIL="$2"
export NEW_AUTHOR="$3"
export NEW_EMAIL="$4"

[ -d .git/refs/original/ ] && rm -r .git/refs/original/

git filter-branch --commit-filter \ '
  if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
  then
    export GIT_COMMITTER_NAME="$NEW_AUTHOR"
    export GIT_COMMITTER_EMAIL="$NEW_EMAIL"
  fi
  if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
  then
    export GIT_AUTHOR_NAME="$NEW_AUTHOR"
    export GIT_AUTHOR_EMAIL="$NEW_EMAIL"
  fi

  git commit-tree ${@}' --tag-name-filter cat -- --branches --tags 

rm -rf .git/logs/
rm -rf "$(git rev-parse --git-dir)/refs/original/"
