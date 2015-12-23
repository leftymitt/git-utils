#!/bin/sh

# change the email and committer name in git history. run from the base of the 
# repository. Variables: 
#    OLD_EMAIL = the address to be changed
#    CORRECT_EMAIL = address to change it to
#    CURRENT_NAME = the name of the author associalted with CORRECT_EMAIL

[ -d .git/refs/original/ ] && rm -r .git/refs/original/

git filter-branch --commit-filter '
OLD_EMAIL=""
CORRECT_NAME=""
CORRECT_EMAIL=""

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
	then
	export GIT_COMMITTER_NAME="$CORRECT_NAME"
	export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
	then
	export GIT_AUTHOR_NAME="$CORRECT_NAME"
	export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi

git commit-tree "$@"
' --tag-name-filter cat -- --branches --tags 

rm -r .git/logs/
