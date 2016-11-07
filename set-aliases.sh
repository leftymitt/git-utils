#! /bin/bash
set -eu

################################################################################
# set aliases to add to git. they are (so far): 
#
#   git sneaky: 
#     set time zone to UTC and make the time of day random by taking 00:00:00
#     UTC of the current day and adding a random offset. 
# 
#   git backtrack:
#     set time zone to UTC and make the time of day random by taking 00:00:00
#     UTC of the current day and adding a random offset. 
#
################################################################################

# change to --global to use this alias in all your repos
git config --local alias.sneaky \
  '! RAND_OFFSET="$(shuf -i 0-86399 -n 1)" && BASE_DATE=$(date -u -d "") && RAND_DATE=$(date -u -d "$BASE_DATE + $RAND_OFFSET seconds") && export GIT_AUTHOR_DATE="$RAND_DATE" && export GIT_COMMITTER_DATE="$RAND_DATE" && git commit'

git config --local alias.backtrack \
  '! RAND_OFFSET="$(shuf -i 0-86399 -n 1)" && BASE_DATE=$(date -u -d "") && RAND_DATE=$(date -u -d "$BASE_DATE + $RAND_OFFSET seconds") && export GIT_AUTHOR_DATE="$RAND_DATE" && export GIT_COMMITTER_DATE="$RAND_DATE" && git revert'

