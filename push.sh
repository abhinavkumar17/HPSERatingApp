CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
LAST_COMMIT=$(git rev-list -1 HEAD)

echo Automatically merging commit $LAST_COMMIT from $CURRENT_BRANCH rippling to master

case $CURRENT_BRANCH in
2.1)
  git checkout 2.2 ＆＆ git merge $CURRENT_BRANCH
  git checkout 2.3 ＆＆ git merge 2.2
  git checkout master ＆＆ git merge 2.3
  git checkout $CURRENT_BRANCH
  ;;
2.2)
  git checkout 2.3 ＆＆ git merge 2.2
  git checkout master ＆＆ git merge 2.3
  git checkout $CURRENT_BRANCH
  ;;
2.3)
  git checkout master ＆＆ git merge 2.3
  git checkout $CURRENT_BRANCH
  ;;
esac