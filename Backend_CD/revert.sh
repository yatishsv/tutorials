git pull
ch=$(git log --merges origin/master -1 --pretty=format:"%H")
git revert --no-commit -m 1 $ch
git commit -m "rolling back changes"
git push -u origin master

