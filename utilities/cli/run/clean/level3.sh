# Cleaning level 3 is supposed to remove file version duplicates in the user data folder
# This is very likely to be effective in freeing up storage, so it is allowed to take a bit of time

./cli run nodeApp "$(pwd)/utilities/cli/run/clean/level3.txt" --root-folder "$(pwd)"