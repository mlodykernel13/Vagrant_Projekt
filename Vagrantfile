Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.hostname = "jupyterhub-vm"
  config.vm.network "forwarded_port", guest: 8000, host: 8000

  #folder projektu
  config.vm.synced_folder ".", "/vagrant"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = 2
  end

  #docker
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y docker.io curl

    # dodanie użytkownika vagrant do grupy docker
    sudo usermod -aG docker vagrant

    # instalacja docker-compose
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    # przejście do katalogu z projektem
    cd /vagrant

    #uruchomienie kontenerów
    sudo docker-compose up -d --build
  SHELL
end
