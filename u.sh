#!/bin/bash

# Check if on the correct branch
current_branch=$(git branch --show-current)
echo "Current branch is $current_branch. Make sure this is the branch you want to modify."

# Interactive rebase starting from the first commit on the branch
# to get all commits in the branch history
echo "Starting interactive rebase from the first commit..."
git rebase -i --root

# In the rebase editor, replace "pick" with "edit" for all commits
# You may have to do this manually or automate it in an editor if possible

# Function to update commit dates by one month
update_commit_date() {
  git rebase --continue
  git filter-branch --env-filter '
    GIT_COMMITTER_DATE=$(date -d "$GIT_COMMITTER_DATE -1 month" "+%Y-%m-%d %H:%M:%S")
    GIT_AUTHOR_DATE=$GIT_COMMITTER_DATE
    export GIT_COMMITTER_DATE
    export GIT_AUTHOR_DATE
  '
}

# Apply the date adjustment to each commit in rebase
while [ "$(git status --porcelain)" ]; do
  echo "Updating commit date..."
  update_commit_date
done

echo "Commit dates have been updated by one month."

# Force push to update the remote branch (WARNING: rewriting history)
echo "Pushing the changes to origin with --force..."
git push origin "$current_branch" --force

