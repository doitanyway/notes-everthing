#!/bin/bash 

# ./for.sh -a --banana blala
while true; do
    case "$1" in
      -a | --apple)
          echo "I have an apple!"
          shift
          ;;
      -b | --banana)
          echo "I have a banana,banana is $2"
          shift 2
          ;;
      -c | --cherry)
          case $2 in
            '')
                echo "I have a cherry!"
                shift 2
                ;;
            *)
                echo "I have a cherry!It is $2"
                shift 2
                ;;
          esac
          ;;
      -d)
          echo "I have a dog!"
          shift
          ;;
      --)
          shift
          break
          ;;
      *)
          echo "get parameters success.!"
          # exit 1
          break
          ;;
    esac
done
echo "end of get parameters success."