#!/usr/bin/env bash

LOG_PATH="/vagrant/log.txt"
RESOURCES_PATH="/vagrant/resources"

function configureSystem()
{
    local time=$(date "+%Y-%m-%d %H:%M:%S")

    echo -e "${GREEN}[${time}][System] Konfiguracja systemu.${NORMAL}" 
    {
		# ustawienie czasu lokalnego
        sudo timedatectl set-timezone Europe/Warsaw
        # kopiowanie certyfikatu Fortinet
        sudo cp ${pathToResources}/Fortinet_CA_SSLProxy.crt /usr/local/share/ca-certificates/
        sudo update-ca-certificates
		sudo chmod +r /usr/local/share/ca-certificates/Fortinet_CA_SSLProxy.crt
    } &>> $LOG_PATH
}

function updateSystem
{
    local time=$(date "+%Y-%m-%d %H:%M:%S")

    echo -e "${GREEN}[${time}][System] Aktualizacja systemu.${NORMAL}" 
    
    {
		# aktualizacja systemu
        sudo apt-get update
        sudo apt-get -y upgrade
    } &>> $LOG_PATH
}

function installZsh
{
    local time=$(date "+%Y-%m-%d %H:%M:%S")

    echo -e "${GREEN}[${time}][System] Instalacja oraz konfiguracja Zsh.${NORMAL}"
     
    {
		# instalacja Zsh
        sudo apt-get install -y curl git zsh unzip
		wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh 
		sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bira"/g' ~/.zshrc
		cp -rv ~/.zshrc /home/vagrant/
		cp -rv ~/.oh-my-zsh /home/vagrant/
		sed -i 's,export ZSH=/root/.oh-my-zsh,export ZSH=/home/vagrant/.oh-my-zsh,g' /home/vagrant/.zshrc
		chown vagrant:vagrant -R /home/vagrant/.oh-my-zsh
		chown vagrant:vagrant -R /home/vagrant/.zshrc
		sudo chsh -s /bin/zsh vagrant	
    } &>> $LOG_PATH
}

# Konfiguracja systemu.
eval configureSystem

# Aktualizacja systemu.
eval updateSystem

# Instalacja Zsh.
eval installZsh
