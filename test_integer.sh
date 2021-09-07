#!/bin/bash

# The purpose of this script is to see if an integer value falls between 1 and 100.

MIN_VAL=1
MAX_VAL=1000

echo "Please enter an integer:"
read INT

if [[ "$INT" =~ ^-?[0-9]+$ ]]; then
    if [[ "$INT" -ge "$MIN_VAL" && "$INT" -le "$MAX_VAL" ]]; then
        echo "$INT is within $MIN_VAL and $MAX_VAL."
    elif [[ "$INT" =~ ^-[0-9]+$ ]]; then
        echo "$INT is a negative number."
    else
        echo "$INT is out of range."
    fi
else
    echo "$INT is not an integer." >&2
    exit 1
fi

if ((((INT % 2)) == 0)); then
    echo "$INT is an even number."
else
    echo "$INT is an odd number."
fi

exit