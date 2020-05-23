#!/bin/bash 

# echo 0:$0
# echo 1:$1 

note=${1:-"commit"}
echo note:$note

#!/bin/bash 
note=${1-"commit note"}
echo $note
git add .
git commit -m "$note"
# push to git hub
git push 
# push to mayun
git push mayun 


