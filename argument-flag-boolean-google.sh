#!/bin/bash

a_flag=''
b_flag=''
files=''
verbose='false'

print_usage() {
  printf "Usage: ..."
}

while getopts 'abf:v' flag; do
  case "${flag}" in
    a) a_flag='true' ;;
    b) b_flag='true' ;;
    f) files="${OPTARG}" ;;
    v) verbose='true' ;;
    *) print_usage
       exit 1 ;;
  esac
done

if $a_flag; then
    echo a_flag triggered!
fi

# Note: If a character is followed by a colon (e.g. f:), that option is expected to have an argument.

# Example usage: ./script -v -a -b -f filename

# Using getopts has several advantages over the accepted answer:

# the while condition is a lot more readable and shows what the accepted options are
# cleaner code; no counting the number of parameters and shifting
# you can join options (e.g. -a -b -c → -abc)
# However, a big disadvantage is that it doesn't support long options, only single-character options.