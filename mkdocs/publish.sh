#!/usr/bin/env zsh
# Usage: ./publish [commit_message]

COMMIT_MSG=${1:-"Work in progress $(date)"}
HOST='lambent.net'
SITEDIR='site'
USR='stephen'
WEBSITE='lambenttechnology.com/wireframes/build.dyalog.com'

git add . && \
git commit -m $COMMIT_MSG && \
echo 'Committed changes to Git' && \
git push origin main &&\
echo 'Pushed source to GitHub' && \
mkdocs build --site-dir $SITEDIR && \
echo "Compiled static HTML in $SITEDIR/" && \

rsync --delete -ru "$SITEDIR/" "$USR@$HOST:/var/www/$WEBSITE"
if [[ $? -eq 0 ]]; then echo "Published to https://$WEBSITE"; else echo 'Failed to publish'; fi