
# VirtualBox and Vagrant Template

## Command note

### Install VirtualBox and Vagrant

```powershell
choco install virtualbox
choco install vagrant
```

### Power up virtual machine

```shell
vagrant up
```

### Connect to Virtual machine on SSH

```shell
vagrant ssh
```

#### If SSH error is occured

```
<Vagrant::Errors::NetSSHException:"An error occurred in the underlying SSH library that Vagrant uses.
```

```shell
vagrant halt; vagrant up --provision
```

https://stackoverflow.com/questions/38824666/vagrant-up-server-not-starting-because-a-ssh-library-issue

### Testing

```shell
vagrant ssh
podman pull nginx
podman run -p 8080:80 nginx
```

### Shutdown virtual machine

```shell
vagrant halt
```

### Destroy vitural machine

```shell
vagrant destroy -f
```

## Tips

### Ping test in a test container

Ping command needs the "NET_RAW" capability.

```shell
# Create a test container in host.
sudo podman run -d \
    --pod proxy_pod \
    --name test \
    --cap-add=NET_RAW \
    nginx:latest
```

```shell
# Install ping in container bash
apt update
apt install iputils-ping net-tools
```
