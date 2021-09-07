#!/bin/bash

# This is the number game. Guess the correct number between 1 and 10 and you win! :)

MIN_VAL=1
MAX_VAL=10
NUM=$((1 + $RANDOM % 10))

echo "I am thinking of a random number between $MIN_VAL and $MAX_VAL. What is it?"
read INT

if ((INT == NUM)); then
    echo "You win!"
else
    echo "Aww sorry, you lose. :("
    echo "The correct answer was $NUM. Thanks for playing!"
fi

exit