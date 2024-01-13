#!/bin/bash

# Get current date and time for the commit message
current_date_time=$(date "+%Y-%m-%d %H:%M:%S")

# Automatically add all changes
git add .

# Commit changes with the current date and time
git commit -m "Auto daily commit on $current_date_time"

# Just push immediately

git push

# Get the latest tag and increment it
latest_tag=$(git describe --tags `git rev-list --tags --max-count=1`)
IFS='.' read -ra ADDR <<< "$latest_tag"
major=${ADDR[0]}
minor=${ADDR[1]}
patch=${ADDR[2]}

# Increment the patch version. You can modify this to increment major or minor if needed
let "patch+=1"
new_tag="${major}.${minor}.${patch}"

# Create new tag
git tag $new_tag

# Push the new tag
git push --tags

echo "New tag $new_tag created and pushed with commit message 'Auto commit on $current_date_time'"
