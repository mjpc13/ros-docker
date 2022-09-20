ARG ARCH=
ARG ROS_DISTRO= 
FROM ${ARCH}ros:${ROS_DISTRO}-ros-base

LABEL maintainer="Mario Cristovao <mjpc13@protonmail.com>"

ENV ROS_ROOT=/opt/ros/${ROS_DISTRO}
#ENV ROS_PYTHON_VERSION=3
ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash","-c"]

# Install packages
RUN apt-get update \
    && apt-get install -y \
    # Basic utilities
    build-essential \
    apt-utils \
    curl \
    git \
    wget \
    vim \
    nano 

# Install some python packages
RUN if [ "$ROS_DISTRO" = "noetic" ]; \
    then apt-get -y install \
    python3 \
    python3-pip \
    python3-serial \
    python3-rosinstall \
    python3-rosinstall-generator \
    python3-wstool \
    python3-rosdep && \
    pip3 install pybind11 \
    catkin_tools; \
    else apt-get -y install \
        python \
        python-pip \
        python-serial \
        python-rosinstall \
        python-rosinstall-generator \
        python-wstool \
        python-rosdep && \
        pip install pybind11 \
        catkin_tools; \
    fi

# Add ROS packages
RUN apt-get install -y ros-$ROS_DISTRO-rosbridge-server

# Clean-up
RUN apt-get clean

#Configure catkin workspace
ENV CATKIN_WS=/root/catkin_ws
RUN mkdir -p $CATKIN_WS/src
WORKDIR $CATKIN_WS
RUN catkin init

RUN echo "source /usr/local/bin/catkin_entrypoint.sh" >> /root/.bashrc
COPY catkin_entrypoint.sh /usr/local/bin/catkin_entrypoint.sh
RUN chmod +x /usr/local/bin/catkin_entrypoint.sh


ENTRYPOINT ["/usr/local/bin/catkin_entrypoint.sh"]
CMD ["bash"]
