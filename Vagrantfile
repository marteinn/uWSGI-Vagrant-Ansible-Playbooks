# -*- mode: ruby -*-
# vi: set ft=ruby tabstop=2

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # Setup server
  config.vm.provision "webserver", type: "ansible" do |ansible|
    ansible.extra_vars = {
      ansible_ssh_user: 'vagrant',
      deploy_user: 'vagrant'
    }
    ansible.playbook = "ansible/webserver.yml"
  end

  # Create app
  config.vm.provision "webapp", type: "ansible" do |ansible|
    ansible_extra_vars = {
      ansible_ssh_user: 'vagrant',
      deploy_user: 'vagrant'
    }

    if ENV['APP_NAME']
      ansible_extra_vars['app_name'] = ENV['APP_NAME']
    end

    if ENV['APP_DOMAIN']
      ansible_extra_vars['app_domain'] = ENV['APP_DOMAIN']
    end

    ansible.extra_vars = ansible_extra_vars
    ansible.playbook = "ansible/webapp.yml"
  end

  # Your uwsgi application (remember to update this)
  config.vm.synced_folder "./src", "/home/vagrant/default_app/web"

  # Application folder (in case you need files outside your source dir)
  # Can be the same as the folder you added below
  config.vm.synced_folder "./", "/home/vagrant/default_app/app"
end
