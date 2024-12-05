Vagrant.configure("2") do |config|
  config.vm.provision "file", source: "config", destination: "$HOME/work/"
  config.vm.provision :vagrant_user, type: "shell", path: "init.sh", privileged: false
  config.vm.box = "bento/ubuntu-24.04"
  # config.vm.box_version = "202407.23.0"
  # config.vm.provision :vagrant_user, type: "shell", inline: "echo $(whoami)", privileged: false
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.synced_folder "server_files/", "/server/", create: true
end