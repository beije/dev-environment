# Dev-environment #

A basic clean LAMP stack dev-environment on Debian Testing x64. To run this you'll need to install virtualbox, vagrant and puppet.

## Usage ##

After you've installed the necessary programs and followed the steps under Installation, navigate to the folder `dev-environment/` (to be clear, in the folder where `Vagrantfile` resides) with your favourite CLI-terminal and run `vagrant up`.

**... Go grab a coffee, this might take a while ...**

Vagrant will download an empty box, called `debian-testing_x64` from dropbox and then mount the folder `dev-environment/` as `/vagrant/` in the guest system. Vagrant will also forward port 80 and port 2222 to your localhost (port 80 for web and port 2222 for ssh).

For easier usage add this to your local `hosts` file:


    127.0.0.1       dev-environment.local
 

If nothing happens when you navigate to `dev-environment.local` with your web browser, it might mean that Vagrant needs to run as an elevated user. Understandably, you don't want to run vagrant as root, so you can change the portforward in the file `Vagrantfile` on the line `config.vm.forward_port 80, 80`.

### Credentials ###

#### System ####
* `root` = vagrant
* `vagrant` = vagrant

#### MySQL ####
* `root` = (Empty)

### Other commands ###

* `vagrant halt`    = Stops the machine
* `vagrant destroy` = Completely removes the machine
* `vagrant suspend` = Save the current state and hibernates the machine
* `vagrant resume`  = Resumes the machine
* `vagrant ssh`     = Starts an ssh session to the virtual machine

## Installation ##

To be able to run this environment you need to have the following programs installed:

* Virtualbox ([https://www.virtualbox.org/](https://www.virtualbox.org/))
* Vagrant ([http://www.vagrantup.com/](http://www.vagrantup.com/))
* Puppet CE ([https://puppetlabs.com/](https://puppetlabs.com/))

### Windows ###

1. Download all the installers from the above links. Start with installing virtualbox, then vagrant and then finally puppet.
2. Reboot your computer.
4. Create folder `www` in `dev-environment/` (Because git can't handle empty folders, this is where you can put all your web things)
5. Navigate to the folder using PowerShell
6. See **usage**

### Linux ###

1. Run `apt-get install virtualbox puppet vagrant`
2. Create folder `www` in `dev-environment/` (Because git can't handle empty folders, this is where you can put all your web things)
4. See **usage**