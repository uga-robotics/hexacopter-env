# hexacopter-env
Dockerfile to setup a ROS2 Foxy Linux environment for working on the AutonomousHexacopter project

## Building the Docker Image on Your Local Machine

### Install Docker

Follow the instructions for your operating system to install Docker:

1. [Linux](https://docs.docker.com/engine/install/)
2. [Windows](https://docs.docker.com/docker-for-windows/install/)
3. [MacOS](https://docs.docker.com/docker-for-mac/install/)

Make sure to test your Docker install with the instructions provided.

### Enable Docker BuildKit

1. **Linux** - To enable BuildKit for a one time build, simply preempt the build command with the BuildKit environment variable as below:
```
DOCKER_BUILDKIT=1 docker build --ssh default .
```

If you would like to enable BuildKit by default (not recommened if you plan to do any Windows containers/builds from your linux machine), add the following to your `/etc/docker/daemon.json`:
```
{ "features": { "buildkit": true } }
```

2. **Windows** - To enable BuildKit on Windows, you can follow a similar proceedure to the Linux version, using PowerShell and the Docker Desktop preferences UI. For a one time build, use PowerShell to enter the following environment variable:
```
$env:DOCKER_BUILDKIT = 1
```

To enable BuildKit by default on Windows, you should navigate to the Docker Preferences menu, and edit the daemon.json file to add the following:
```
{ "features": { "buildkit": true } }
```

> **Note**: You cannot build Windows images (non-WSL images) with BuildKit enabled.

### Generate/Add ssh key to ssh agent



### Build with command



## Running the Generated Docker Container

1. run with command to enable xserver stuff (Linux and Windows)
2. connecting multiple terminal windows to container