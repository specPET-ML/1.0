Vagrant.configure(2) do |config|
 
  # BOX
  config.vm.box = "ubuntu/trusty32"

  # NETWORK
  config.vm.network :forwarded_port, guest: 80, host: 8085
  config.vm.network :forwarded_port, guest: 3306, host: 33060
  config.vm.network :private_network, ip: "192.168.21.7"
  
  # FOLDER
  config.vm.synced_folder "data", "/vagrant", :nfs => { :mount_options => ["dmode=777", "fmode=777"] }
  
  # SHELL

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  config.vm.provision "default", type: "shell", path:"enviroments.sh"

end
