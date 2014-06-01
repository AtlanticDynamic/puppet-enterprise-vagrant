# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# the prefix of the pe install tar, minus the .tar.gz
PUPPET_ENTERPRISE_VERSION = "puppet-enterprise-3.2.3-el-6-x86_64"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # The url from where the 'config.vm.box' box will be fetched if it
  # This is from http://puppet-vagrant-boxes.puppetlabs.com/
  config.vm.provider :vmware_fusion do |v, override|
    override.vm.box = "centos-64-x64-fusion503-nocm"
    override.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-fusion503-nocm.box"
  end

  config.vm.provider "virtualbox" do |v, override|
    override.vm.box = "centos-64-x64-vbox4210-nocm.box"
    override.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210-nocm.box"
  end
  
  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  # Disable firewall
  config.vm.provision :shell, :inline => "sudo service iptables stop"
  config.vm.provision :shell, :inline => "sudo chkconfig iptables off"

  if Vagrant.has_plugin?("vagrant-hostmanager")
    # Update /etc/hosts on all active machines.
    config.hostmanager.enabled = true

    # manage /etc/hosts
    config.vm.provision :hostmanager
  else
    abort("Please install the hostmanager vagrant plugin: vagrant plugin install vagrant-hostmanager")
  end

  config.vm.define :master do |master|
    #master.vm.provision "puppet" do |puppet|
    #puppet.manifests_path = "puppet"
    #puppet.manifest_file = "master.pp"
    #end
    master.vm.provider "vmware_fusion" do |v, override|
      v.vmx["memsize"]  = "1536"
    end
    master.vm.provision :shell, :inline => "sudo bash -c '/vagrant/pe-install/bootstrap.sh #{PUPPET_ENTERPRISE_VERSION} /vagrant/pe-install/answers.lastrun.puppet'"
    master.vm.provision :shell, :inline => "sudo /opt/puppet/bin/puppet apply /vagrant/pe-install/autosign.pp"
    master.vm.hostname = "puppet"
  end

  config.vm.define :agent do |agent|
    agent.vm.provision :shell, :inline => "sudo bash -c '/vagrant/pe-install/bootstrap.sh #{PUPPET_ENTERPRISE_VERSION} /vagrant/pe-install/answers.lastrun.node1'"
    agent.vm.hostname = "node1"
    agent.vm.provision :shell, :inline => "sudo /opt/puppet/bin/puppet agent -t"
  end
  
  #config.vm.synced_folder "/etc/puppet", "/etc/puppet"
  
  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file pl-centos-6-x64.pp in the manifests_path directory.
  #
  # An example Puppet manifest to provision the message of the day:
  #
  # # group { "puppet":
  # #   ensure => "present",
  # # }
  # #
  # # File { owner => 0, group => 0, mode => 0644 }
  # #
  # # file { '/etc/motd':
  # #   content => "Welcome to your Vagrant-built virtual machine!
  # #               Managed by Puppet.\n"
  # # }
  #
  # config.vm.provision "puppet" do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "site.pp"
  # end
end
