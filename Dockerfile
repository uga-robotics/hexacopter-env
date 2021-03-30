# Based on the ROS2 Foxy Dockerfile by Tiryoh
# https://github.com/Tiryoh/docker_ros2/blob/feature/support-foxy/ubuntu/focal/amd64/foxy/Dockerfile
FROM ubuntu:20.04
LABEL maintainer="Kevin Koffroth <ktkoffroth@gmail.com>"
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "Set disable_coredump false" >> /etc/sudo.conf
RUN apt-get update -q && \
    apt-get upgrade -yq && \
    apt-get install -yq keyboard-configuration && \
    apt-get install -yq wget curl openssh-client git build-essential vim sudo lsb-release locales bash-completion tzdata gosu openjdk-8-jdk-headless && \
    rm -rf /var/lib/apt/lists/*
RUN useradd --create-home --home-dir /home/ubuntu --shell /bin/bash --user-group --groups adm,sudo ubuntu && \
    echo ubuntu:ubuntu | chpasswd && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN locale-gen en_US.UTF-8
RUN git clone https://github.com/Tiryoh/ros2_setup_scripts_ubuntu.git /tmp/ros2_setup_scripts_ubuntu && \
     gosu ubuntu /tmp/ros2_setup_scripts_ubuntu/ros2-foxy-desktop-main.sh && \
     rm -rf /var/lib/apt/lists/*
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts
RUN mkdir /home/ubuntu/docker_ws && \
    cd /home/ubuntu/docker_ws
RUN --mount=type=ssh git clone --recurse-submodules git@github.com:uga-robotics/AutonomousHexacopter.git /home/ubuntu/docker_ws/src/AutonomousHexacopter
USER ubuntu
WORKDIR /home/ubuntu
ENV HOME=/home/ubuntu
RUN sudo chmod -R 777 /home/ubuntu/docker_ws && \
    cd /home/ubuntu/docker_ws/src/AutonomousHexacopter/PX4-Autopilot && git checkout uga-dev && \
    cd ../px4_msgs && git checkout a635d9d827ac36a51411e03b9b8eb25a599dc734 && \
    cd ../px4_ros_com && git checkout uga-dev && cd ../ && \
    ./scripts/install_deps.sh && \
    ./scripts/rtps_install.sh && \
    curl -sSL http://get.gazebosim.org | sh
RUN export DISPLAY=127.0.0.1:0.0
ENV ROSDISTRO=foxy
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8
CMD ["bash"]
