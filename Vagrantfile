# -*- mode: ruby -*-
# vi: set ft=ruby tabstop=2 expandtab shiftwidth=2 softtabstop=2 :
SERVERS = {
  :master => {
    :ip => '172.31.70.40',
    :provisioner => [:server, :enable_root_ssh],
    :box => 'debian85',
  },
  :debian => {
    :ip => '172.31.70.41',
    :provisioner => [:desktop, :enable_root_ssh],
    :box => 'debian85-desktop',
  },
  :windows => {
    :ip => '172.31.70.43',
    :provisioner => [:desktop],
    :box => 'eval-win81x64-enterprise',
  }
}

def enable_root_ssh(cfg)
  pkey_file = "#{ENV['HOME']}/.ssh/id_rsa.pub"
  pkey = File.read(pkey_file)
  cfg.vm.provision 'shell',
    inline:
      "mkdir -m 700 -p ~/.ssh && " +
      "install -m 600 /dev/null ~/.ssh/authorized_keys && " +
      "echo '#{pkey}' >> ~/.ssh/authorized_keys"
end

def server(cfg)
  cfg.cache.scope = :machine if Vagrant.has_plugin? "vagrant-cachier"
  cfg.vm.provider "virtualbox" do |v|
    v.cpus = 4
    v.memory = 2048
    v.gui = false
  end
end

def desktop(cfg)
  cfg.cache.scope = :machine if Vagrant.has_plugin? "vagrant-cachier"
  cfg.vm.provider "virtualbox" do |v|
    v.cpus = 4
    v.memory = 4096
    v.customize ['modifyvm', :id, '--vram', 256]
  end
end

Vagrant.configure("2") do |config|
  SERVERS.each do |server_name, server_details|
    is_primary = server_details[:primary] || false;
    is_autostart = server_details.has_key?(:autostart) ? server_details[:autostart] : true
    config.vm.define(server_name,
                     primary: is_primary,
                     autostart: is_autostart) do |cfg|
      cfg.vm.box = server_details[:box]
      cfg.vm.host_name = server_name.to_s
      cfg.vm.network(:private_network, ip: server_details[:ip])
      (server_details[:ports] || {}).each do |host_port, guest_port|
        cfg.vm.network "forwarded_port", guest: guest_port, host: host_port
      end
      server_details[:provisioner].each { |p| method(p).call(cfg) }
    end
  end
end

