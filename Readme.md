
# VirtualBox and Vagrant Template

## Command note

### Install VirtualBox and Vagrant

```powershell
choco install virtualbox
choco install vagrant
```

### Setup SSL keys for HTTPS connection to localhost

I define hostname `dev.local`.

```powershell
choco install mkcert
mkcert -install
mkcert dev.local
mv .\dev.local.pem .\server_files\pod_sample\pods\proxy_pod\containers\nginx\conf.d\
mv .\dev.local-key.pem .\server_files\pod_sample\pods\proxy_pod\containers\nginx\conf.d\

mkcert mail.dev.local
mv .\mail.dev.local.pem .\server_files\pod_sample\pods\mail_pod\containers\docker_mailservice\custom-certs\
mv .\mail.dev.local-key.pem .\server_files\pod_sample\pods\mail_pod\containers\docker_mailservice\custom-certs\
```

Add the below 2 lines into the file `C:\Windows\System32\drivers\etc\hosts`.

```
192.168.33.10 dev.local
192.168.33.10 mail.dev.local
```

### Power up virtual machine

```shell
vagrant up
```

### Connect to Virtual machine on SSH

```shell
vagrant ssh
```

#### If some error is occured

Just retry until success.

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

### Insert test users into LDAP server

In virutal machine's console,

```shell
sudo podman exec -it openldap ldapadd -x -D "cn=admin,dc=dev,dc=local" -w admin -f /openldap/testuser.ldif -ZZ
sudo podman exec --user=root -it openldap ldapadd -ZZ -x -W -D "cn=admin,cn=config" -f /openldap/postfix.ldif
ldapadd -ZZ -x -W -D "cn=admin,cn=config" -f /openldap/hoge.ldif
```
