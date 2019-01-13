## Docker Development Environment

Wouldn't it be cool to use your local machines Editors & IDEs, but /run/ your code on a production like system... without needing to sync, deploy, or rebuild code?  Well... with the magic of Docker, you can!

The trick is to mount your local development folder /inside/ your docker image.  This project creates an easy-to-use image which you can SSH to to *run* your code from your local machine.  The commands below show you how.  

This package comes with Node and Ruby installed, but you can add your own.

## Get it running

```bash
# Build
docker build -t devbox:latest .

# Run
# Change `~/PROJECTS` to the directory you want to mount on your host
docker run -d  --name devbox-live -v ~/PROJECTS:/projects -p 2222:22 devbox:latest

# Connect
ssh -X root@localhost -p 2222
```

## Project Goals
* No use of `sudo` on the host (your laptop)
* Ability to have separate, easy-to-swap and start over VMs for each project.  No more fighting with versions or dependencies
* Ability to mount to other docker VMs for databases or external services.  `docker-compose` is great at this.
* Nothing magic: all configuration viewable in bash or docker commands

## Notes
* inspired by https://github.com/mikadosoftware/workstation
