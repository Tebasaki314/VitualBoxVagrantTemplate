
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

#### If SSH error is occured

```
<Vagrant::Errors::NetSSHException:"An error occurred in the underlying SSH library that Vagrant uses.
```

```shell
vagrant halt
vagrant up --provision
```

https://stackoverflow.com/questions/38824666/vagrant-up-server-not-starting-because-a-ssh-library-issue

### Testing

```shell
podman pull nginx
podman run -p 8080:80 nginx
```

### Destroy vitural machine

```shell
vagrant destroy -f
```
