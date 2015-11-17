#!/usr/bin/env bash

# Run this with a command to install Phoenix
#   example (optional flags):
#   ./create_phoenix chatty --no-brunch

APP_NAME=$1
echo "Creating project ${APP_NAME}"
cd ..
# call with all args
mix phoenix.new "${@}"
# rename project folder to server
#mv server/install.sh install.sh

#mv server/$APP_NAME server2
#cd server

echo "\nProject complete"
echo "To get started:"
echo "  mix phoenix.server"
