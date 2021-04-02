# Based on the ROS2 Foxy Dockerfile by Tiryoh
# https://github.com/Tiryoh/docker_ros2/blob/feature/support-foxy/ubuntu/focal/amd64/foxy/Dockerfile
FROM ubuntu:20.04
LABEL maintainer="Kevin Koffroth <ktkoffroth@gmail.com>"
ENV DEBIAN_FRONTEND=noninteractive
ADD scripts /tmp
RUN echo "Set disable_coredump false" >> /etc/sudo.conf && \
    apt-get update -q && \
    apt-get upgrade -yq && \
    apt-get install -yq keyboard-configuration && \
    apt-get install -yq wget curl openssh-client git build-essential vim sudo lsb-release locales bash-completion tzdata gosu openjdk-8-jdk-headless && \
    rm -rf /var/lib/apt/lists/* && \
    useradd --create-home --home-dir /home/ubuntu --shell /bin/bash --user-group --groups adm,sudo ubuntu && \
    echo ubuntu:ubuntu | chpasswd && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    locale-gen en_US.UTF-8&& \
    /tmp/ros2-foxy-desktop-main.sh && \
    rm -rf /var/lib/apt/lists/* && \
    /tmp/install_deps.sh && \
    /tmp/rtps_install.sh && \
    curl -sSL http://get.gazebosim.org | sh && \
    export DISPLAY=127.0.0.1:0.0 &&\
    echo "source /opt/ros/foxy/setup.bash" >> /home/ubuntu/.bashrc
USER ubuntu
WORKDIR /home/ubuntu
ENV HOME=/home/ubuntu
ENV ROSDISTRO=foxy
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8
CMD ["bash"]
