#!/bin/bash 

# echo 0:$0
# echo 1:$1 

note=${1:-"commit"}
echo note:$note

git add .
git commit -m "$note"
# push to git hub
git push 
# push to mayun
git push mayun 






curl -v --user 'admin:admin123'  \
    --upload-file /data/server/wizard_uni/union-test/jar.zip  \
     http://218.80.192.236:9001/repository/raw-repo/jars/test/jar.zip


