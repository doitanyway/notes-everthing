#!/bin/bash 

# echo 0:$0
# echo 1:$1 

note=${1:-"commit"}
echo note:$note

git add .
git commit -m "$note"
git push 
git push mayun 