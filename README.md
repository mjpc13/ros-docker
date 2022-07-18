# Ros Docker

![GitHub Workflow Status (branch)](https://img.shields.io/github/workflow/status/mjpc13/ros-docker/build%20base%20image/main?color=blue&label=base&style=for-the-badge)

![GitHub Workflow Status (branch)](https://img.shields.io/github/workflow/status/mjpc13/ros-docker/build%20base%20image/core?color=blue&label=core&style=for-the-badge)

Repository to store and manage my Dockerfiles of ROS enviroments.

```bash
docker build -t your-username/your-repo:your-tag --build-arg ARCH=amd64/ --build-arg ROS_DISTRO=noetic .
```
This **tag** pulls from the ROS core image and adds a ngrok service.