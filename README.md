# Ros Docker
Repository to store and manage my Dockerfiles of ROS enviroments.

```bash
docker build -t your-username/your-repo:your-tag --build-arg ARCH=amd64/ --build-arg ROS_DISTRO=noetic .
```
This **tag** pulls from the ROS core image and adds a ngrok service.