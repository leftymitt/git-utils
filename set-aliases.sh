#! /bin/bash
set -eu

################################################################################
# set aliases to add to git. they are (so far): 
#
#   git sneaky: 
#     wrapper for 'git commit' that sets the time zone to UTC and makes the
#     time of day random by taking 00:00:00 UTC of the current day and adding a
#     random offset. 
# 
#   git backtrack:
#     wrapper for 'git revert' that sets the time zone to UTC and makes the
#     time of day random by taking 00:00:00 UTC of the current day and adding a
#     random offset. 
#
################################################################################

# change to --global to use this alias in all your repos
# git config --local alias.sneaky \
#   '! RAND_OFFSET="$(shuf -i 0-86399 -n 1)" && BASE_DATE=$(date -u -d "") && RAND_DATE=$(date -u -d "$BASE_DATE + $RAND_OFFSET seconds") && export GIT_AUTHOR_DATE="$RAND_DATE" && export GIT_COMMITTER_DATE="$RAND_DATE" && git commit'
# 
# git config --local alias.backtrack \
#   '! RAND_OFFSET="$(shuf -i 0-86399 -n 1)" && BASE_DATE=$(date -u -d "") && RAND_DATE=$(date -u -d "$BASE_DATE + $RAND_OFFSET seconds") && export GIT_AUTHOR_DATE="$RAND_DATE" && export GIT_COMMITTER_DATE="$RAND_DATE" && git revert'

ENV='! '
ENV=${ENV}'RAND_OFFSET="$(shuf -i 0-86399 -n 1)" && '
ENV=${ENV}'BASE_DATE=$(date -u -d "") && '
ENV=${ENV}'RAND_DATE=$(date -u -d "$BASE_DATE + $RAND_OFFSET seconds") && '
ENV=${ENV}'export GIT_AUTHOR_DATE="$RAND_DATE" && '
ENV=${ENV}'export GIT_COMMITTER_DATE="$RAND_DATE" && '

# set commit wrapper. change to --global to use this alias in all your repos.
git config --local alias.sneaky "${ENV} git commit"

# set revert wrapper. change to --global to use this alias in all your repos.
git config --local alias.backtrack "${ENV} git revert"
