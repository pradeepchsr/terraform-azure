#!/bin/bash

# This is a simple test script

# Print a greeting
echo "Hello! This is a test script."

# Print the current date and time
echo "The current date and time is: $(date)"

# Display the contents of /etc/passwd
echo "Contents of /etc/passwd:"
cat /etc/passwd

# Check if a file named "testfile.txt" exists in the current directory
if [ -e "testfile.txt" ]; then
    echo "The file 'testfile.txt' exists."
else
    echo "The file 'testfile.txt' does not exist."
fi