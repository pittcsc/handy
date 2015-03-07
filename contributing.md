# Contributing Quickstart

## Purpose

This guide will help you quickly set up a development environment where you can contribute code to Handy. This guide will be especially useful for newcomers to Rails development.

Specifically, this guide will show you how to use VirtualBox and Vagrant to set up your dev environment with a virtual machine (VM). If you feel comfortable with Rails and don't want to use a VM, this guide isn't for you.

## Prerequisites

We'll use VirtualBox and Vagrant to prepare our environment.

Go [here](https://www.virtualbox.org/) to get VirtualBox for your machine.

Then, go [here](https://www.vagrantup.com/) to get Vagrant.

VirtualBox is a VM provider. It does the actual work of hosting a fake computer (the VM) in your computer (the host). Vagrant is a tool that works on top of VirtualBox. It makes sharing and configuring development environments easy.

Once you've installed the tools, I recommend going through Vagrant's [_Getting Started_](http://docs.vagrantup.com/v2/getting-started/index.html) guide so you understand what's going on and you're confident your installations were successful. Or don't. I'm not the boss of you.

## Get the Quickstart Box

I created a "base box" configured specially for Handy development. It's an Ubuntu (Linux) image with all the dependencies you'll need to start the development server*. You can download it from my Google Drive [here](https://drive.google.com/file/d/0B4TO8N-e7-6YbDhBZXROY19xY0k/view?usp=sharing). 

Once you've downloaded handy-quickstart.box, let Vagrant know it exists like so:
`vagrant box add handy-quickstart handy-quickstart.box`

## Configure the VM

Now you're ready to spin up your virtual machine. In the directory where you want to place Handy's code, make a file called `Vagrantfile`. It must be named `Vagrantfile`. It must have no extension. (e.g. `Vagrant.txt` will fail.)

The Vagrantfile is where we will configure our VM. Below is the Vagrantfile I use. I recommend you use it as-is (assuming you have at least 8 GB of RAM and 2 processors).

```
Vagrant.configure(2) do |config|

  config.vm.box = "handy-quickstart"
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  
  config.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.memory = 4096
      v.cpus = 2
  end

end
```

Let me explain a few things. The first command `config.vm.box = "handy-quickstart"` tells Vagrant that we want to use the base box that we just imported. The second command `config.vm.network :forwarded_port, guest: 3000, host: 3000` will make sure that when the Rails server serves a webpage on the VM, it will get passed on to the host. The commands in the `config.vm.provider` are performance tweaks. The first two lines solve connection issues Ubuntu VMs run into sometimes. It doesn't hurt to have it in there, and it will probably spare you some frustration. The last two lines let the VM grab a lot of resources from the host machine. This does *not* mean that the VM will hog 4 gigs of RAM and two cores all of the time. It just means that they *can* use those resources if push comes to shove.

## Get Familiar with Your New VM

 If you're not comfortable with Linux and the command line, you might want to take a break now to learn the basics. [Here](http://linuxcommand.org/lc3_lts0010.php) is a nice guide. You can get by if you're comfortable with the first three sections.

 Now that you've created your Vagrantfile, you can `vagrant up` in your project directory and your VM will come to life! Get inside by `vagrant ssh`ing in from the project directory (wherever your Vagrantfile is). If you look at your `pwd`, you'll see that you were dropped in to `/home/vagrant` aka `/~`. This is not the same as the special `/vagrant` directory where we'll be spending most of our time. `cd` to `/vagrant`.

 `/vagrant` is special because Vagrant _synchronizes_ this folder to the project directory on your host machine. So if you add a new file to your project directory, it will show up in `/vagrant` and vice versa. This will let you edit files on your host and run the server on the VM.

## Create Config Files

 It's time to grab Handy code. Clone the repo to `/vagrant` with `git clone https://github.com/Pitt-CSC/handy.git` (or the URL of your fork). If you jump the gun and try to start the server now, you'll see some donk-nasty error messages complaining about `twilio.yml`. handy needs `config/twilio.yml`, `config/secrets.yml`, and `database.yml` to work. But none of those files are there! That's because they contain senstive information that shouldn't be committed to GitHub. 

 Helpfully, the project maintainers have provided sample versions of each file. To get started, you can just use `secrets.yml.sample` as is**. So make a new file called `secrets.yml` with the contents of `secrets.yml.sample`. For `database.yml.sample` we'll need to make one change. 

 The first part looks like
 ```
default: &default
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: root
  password:
 ```

 Change it to
 ```
 default: &default
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: root
  password: root
  ```
 That's because when I configured MySQL on the base box I gave the root user the password `root`.


 ### Setting Up Twilio

 Handy uses Twilio to send and receive text messages. You'll need your own Twilio account to work with Handy. [Go to their website](https://www.twilio.com/) and make an account. You won't need a credit card.

 Once you've signed up for a trial account, [find your account credentials](https://www.twilio.com/user/account/developer-tools/test-credentials). Use them to fill in `twilio.yml`.

 ## Make Sure The Right Gems Are Installed

 In `/vagrant/handy`, run `bundle install` to make sure all of the Ruby gems Handy needs are installed on your VM. I installed them myself on the base box, but as the project changes, Handy will use new gems and the base box will become out of date.

 ## Prepare the Database

We'll need to create the tables that Handy needs in the database. 

 ```
 rake db:drop db:create db:schema:load --trace
 rake db:seed --trace
 ```
That should do it.

 ## Run the server

 You're ready to start! From `/vagrant/handy`, execute `rails server -b 0.0.0.0`. You wouldn't need `-b 0.0.0.0` if you weren't running the server from a VM. By default, the rails server will bind to 127.0.0.1 (aka Localhost). That will get the HTTP responses "stuck" in the VM and not let them through to your host machine. Binding to 0.0.0.0 prevents that.

 Once you've started your server, open up a web browser on the host machine and enter `Localhost:3000` into the address bar. If you see Handy's login page, congratulations! You've set up your development environment!

 ## Now What?

 This is as far as I can take you. Check out the issue tracker to see if there are bugs or enhancements you can work on. Or maybe add something you think would be cool. Good luck!



*(Link to page where I detail configuration of base box forthcoming.)
** But please don't put it in production like that.

