#!/usr/bin/env zsh

# PYANG comilation script

echo "PYANG Compilation Script"

TMP=$(mktemp)
dirname="working"

# Copy all YANG models to single directory
mkdir -p "$dirname"
cp -n *.yang ./$dirname

# Perform PYANG compilation
pyang ./$dirname/*.yang 2>&1 | tee $TMP
# alternative with --lint
# pyang --lint ./$dirname/*.yang 2>&1 | tee $TMP

OUTPUT=$(cat $TMP)

#tidy up
rm $TMP
rm -r ./$dirname

# echo "output is " $OUTPUT

#check for --lint errors
if [[ $OUTPUT = *error* ]];
then
  echo "PYANG compilation failed"
  exit 1
else
  echo "PYANG compilation passed"
  exit 0
fi
