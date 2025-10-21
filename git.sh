#!/bin/sh

branch=$(git rev-parse --abbrev-ref HEAD)
commit=$(git log --oneline -n 1 | awk '{print $1}')
if [ $branch == "HEAD" ]; then
    echo "git:$commit"
elif [ $branch ]; then
    echo "git:$branch"
fi
