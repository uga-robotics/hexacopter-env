# hexacopter-env
Dockerfile to setup a ROS2 Foxy Linux environment for working on the AutonomousHexacopter project

## Building the Docker Image on Your Local Machine

### Install Docker

Follow the instructions for your operating system to install Docker:

1. [Linux](https://docs.docker.com/engine/install/)
2. [Windows](https://docs.docker.com/docker-for-windows/install/)
3. [MacOS](https://docs.docker.com/docker-for-mac/install/)

Make sure to test your Docker install with the instructions provided.

#### Special Directions for Windows

When installing Docker for Windows, **make sure to install the WSL (Windows Subsystem for Linux) 2 backend as directed**, as we'll need WSL 2 to build/use Linux containers, and use Docker in a preffered, unified way (WSL makes it such that Windows, Linux, and MacOS systems can use the same commands/interface). 

When you have the WSL 2 Backend installed correctly, you should then install a Linux Distribution on your Windows machine using the Microsoft Store. This allows you to access the WSL 2 file system with a full operating system, such as Ubuntu. You can [download Ubuntu 20.04 from the Microsoft Store here](https://www.microsoft.com/en-us/p/ubuntu-2004-lts/9n6svws3rx71?activetab=pivot:overviewtab).

In addition to installing and enabling the WSL 2 backend as directed in the Windows installation instructions, you'll also need to enable this functionality in Docker Desktop using this guide on [The Docker Desktop WSL 2 Backend](https://docs.docker.com/docker-for-windows/wsl/#download), Which goes over installation (already covered) and configuration of WSL 2 for use with Docker. The guide has you using the Windows terminal, which can be accessed by opening up PowerShell from the start menu. Make sure to set the default Linux distribution and version in WSL as directed (the name is `Ubuntu-20.04`), and enable the distribution in the Docker Desktop 'WSL Integration' menu in the Resources tab of the settings.

When you have your WSL 2 Linux Distribution setup, launch it for the first time using the start menu (Search 'Ubuntu' and it should come up, you can even pin it to your taskbar) and [do the typical first-time git setup](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup). Also, [generate and add an ssh key in Linux and add it to your GitHub account](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent), as we'll need to use it shortly.

### Enable Docker BuildKit

1. **Linux** - To enable BuildKit for a one time build, simply preempt the build command with the BuildKit environment variable as below:
```
DOCKER_BUILDKIT=1 docker build --ssh default .
```

If you would like to enable BuildKit by default (not recommened if you plan to do any Windows containers/builds from your linux machine), add the following to your `/etc/docker/daemon.json`:
```
{ "features": { "buildkit": true } }
```

2. **Windows** - To enable BuildKit on Windows, you can follow a similar proceedure to the Linux version, using PowerShell and the Docker Desktop Settings UI. For a one time build, use PowerShell to enter the following environment variable:
```
$env:DOCKER_BUILDKIT = 1
```

To enable BuildKit by default on Windows, you should navigate to the Docker Settings menu, navigate to the Docker Engine tab, and edit the `daemon.json` file shown in the window to add the following:
```
"features": { "buildkit": true }
```

> **Note**: You cannot build Windows images (non-WSL images) with BuildKit enabled.

3. **MacOS** - To enable BuildKit for a one-time build, you can follow the linux-style command of preempting the build command with the BuildKit environment variable as below:
```
DOCKER_BUILDKIT=1 docker build --ssh default .
```

To enable BuildKit by default on MacOS (again, not recommended if you plan on build Windows containers), you can follow the same method as on Windows. Simply open up Docker Desktop, navigate to the settings menu, then the Docker Engine tab, and in the JSON field enter the following (if it is not already there):
```
"features": {"buildkit": true}
```
 
### Add SSH Key to SSH Agent

In order to pass our SSH keys to the Docker Container for use while we build/work, we'll need to add our SSH key to the SSH Agent, which provides your SSH Key to applications as a service. First, [ensure you have an SSH, and that it is connected to your GitHub account](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent). 

Next, in your terminal (WSL if on Windows), make sure an SSH Agent process is running by entering the following command:
```
eval "$(ssh-agent -s)"
```

It should return the PID (Process ID) of the agent and exit.

When that is running, execute the command:
```
ssh-add /path/to/key
```

Where `/path/to/key` is the path to your private SSH Key generated previously. This is typically something like `~/.ssh/id_rsa` or `~/.ssh/id_ed25519` if you followed the instructions provided.

Now we're ready to build the Docker Container!

### Build the Docker Container Image

Universally, you should now be able to build the Docker image and run it on your machine. To do this, you should clone this repository (`hexacopter-env`) into WSL if you're on Windows or anywhere on your machine if you're on MacOS or Linux. Simply copy the SSH address and execute `git clone` with it.

After that is done, you now have the `hexacopter-env` repository on your computer, with the Dockerfile included. Navigate into the `hexacopter-env` directory and execute the following command:
```
docker build --ssh default .
```

With BuildKit enabled, this should start building the container image, and it will take around 15-20 minutes depending on your computer, so get a cup of coffee or tea, and watch an episode of your favorite show/YouTube channel, watching out for any build errors.

## Running the Docker Container



## Suggested Workflow

