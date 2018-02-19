echo "$PWD"

echo "ABHINAV"

[ $(git rev-parse HEAD) = $(git ls-remote $(git rev-parse --abbrev-ref @{u} | \
sed 's/\// /g') | cut -f1) ] && echo up to date || echo not up to date


git pull --dry-run | grep -q -v 'Already up-to-date.' && changed=1