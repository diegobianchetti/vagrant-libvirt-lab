Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-24.04"
  config.vm.hostname = "lab.local"

  config.vm.define "lab" do |lab|
    lab.vm.network :private_network, type: "dhcp"

    lab.vm.provider :libvirt do |libvirt|
      libvirt.cpus   = 2
      libvirt.memory = 2048
    end

    lab.vm.provision "shell", path: "provisioning/setup.sh"
  end
end
