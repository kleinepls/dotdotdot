#!/bin/sh

branch=$(git rev-parse --abbrev-ref HEAD)
if [[ $branch ]] then
    echo "git:$branch"
fi
