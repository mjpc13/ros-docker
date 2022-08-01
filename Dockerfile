ARG ARCH=
ARG ROS_DISTRO= 
FROM ${ARCH}mjpc13/ros:${ROS_DISTRO}-base

LABEL maintainer="Mario Cristovao <mjpc13@protonmail.com>"

ENV ROS_ROOT=/opt/ros/${ROS_DISTRO}
ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash","-c"]

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN source $HOME/.cargo/env && cargo install ros-project-generator

# Install Julia
RUN apt update && apt install -y software-properties-common
RUN apt-get install -y julia && \
  rm -rf /var/lib/apt/lists/*

RUN julia -e 'using Pkg; Pkg.add("RobotOS")'

#Install Kotlin
# TODO

CMD ["bash"]
