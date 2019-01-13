## Docker Development Environment

Wouldn't it be cool to use your local machines Editors & IDEs, but /run/ your code on a production like system... without needing to sync, deploy, or rebuild code?  Well... with the magic of Docker, you can!

The trick is to mount your local development folder /inside/ your docker image.  This project creates an easy-to-use image which you can SSH to to *run* your code from your local machine.  The commands below show you how.  

This package comes with Node and Ruby installed, but you can add your own.

```bash
# Build
sudo docker build -t devbox:latest .

# Run
docker run -d  --name devbox-live -v /Users/evan/PROJECTS:/projects -p 2222:22 devbox:latest

# Connect
ssh -X root@localhost -p 2222
```

## Notes
* inspired by https://github.com/mikadosoftware/workstation
