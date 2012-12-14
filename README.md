A Vagrant configured CentOS 6.3 64 box running Apache/PHP/MySQL/Memcache

# 1. Install #

 * Install [Virtualbox](https://www.virtualbox.org/)
 * Install [Vagrant](http://vagrantup.com/)
 * Clone the repo

<pre>
$ git clone git@github.com:colynb/Vagrant_CentOS_LAMP.git
</pre>

# 2. Boot up the VM and get to work! #

<pre>
$	vagrant up
</pre>

This last step takes a minute or two for vagrant to copy files over to the VM and to get it booted up. Once it's done, you should have a working LAMP server. Just open up a browser - on your host machine - and go to <code>http://localhost:8080</code> (Make sure you don't have anything else listening on port 8080 - if you do you can always change to a port of your choosing in the Vagrant file)

