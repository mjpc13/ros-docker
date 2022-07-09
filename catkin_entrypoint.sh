#!/bin/bash

echo "==> Executing image entrypoint ..."
echo "-> Setting up ROS"
source "/opt/ros/$ROS_DISTRO/setup.bash"

echo "==> Configuring ngrok"
if [ -z "${NGROK_TOKEN}" ]; then
    #from environment variable; should be a absolute path to the appropriate workspaces's setup.bash
    echo "--> Not setting up ngrok"
else

    #set up ngrok
    ./ngrok config add-authtoken $NGROK_TOKEN
    echo "==> Executing ngrok"
    ./ngrok http 11311 --log=stdout > ngrok.log &
    echo "--> Finished setting up ngrok"
fi

exec "$@"