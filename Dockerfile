ARG ARCH=
ARG ROS_DISTRO= 
FROM ${ARCH}ros:${ROS_DISTRO}-ros-base

LABEL maintainer="Mario Cristovao <mjpc13@protonmail.com>"

ENV ROS_ROOT=/opt/ros/${ROS_DISTRO}
ENV ROS_PYTHON_VERSION=3


SHELL ["/bin/bash","-c"]

# Add librealsense keys
#RUN apt-get update && \
#    apt-get install -y software-properties-common
#RUN apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
#RUN add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo bionic main"

ENV DEBIAN_FRONTEND=noninteractive
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
#    librealsense2-utils \
#    librealsense2-dev \
#   librealsense2-dbg \
    #libpcl-dev \
    #libyaml-cpp-dev 
    #libgeographic-dev \
    #libbullet-dev \
    #libpcap-dev \
    #libeigen3-dev \ 
    #libomp-dev
    #&& rm -rf /var/lib/apt/lists/*

# Install some python packages
RUN apt-get -y install \
    python3 \
    python3-pip \
    python3-serial \
    python3-rosinstall \
    python3-rosinstall-generator \
    python3-wstool \
    python3-rosdep

RUN pip3 install pybind11 \
    catkin_tools

#Configure catkin workspace
ENV CATKIN_WS=/root/catkin_ws
RUN mkdir -p $CATKIN_WS/src
WORKDIR $CATKIN_WS
RUN catkin init

RUN echo "source /usr/local/bin/catkin_entrypoint.sh" >> /root/.bashrc
COPY catkin_entrypoint.sh /usr/local/bin/catkin_entrypoint.sh
RUN chmod +x /usr/local/bin/catkin_entrypoint.sh


#EXPOSE 11311
ENTRYPOINT ["/usr/local/bin/catkin_entrypoint.sh"]
CMD ["bash"]