class website {

# ================================================================= 
# FIREWALL and SECURITY
# =================================================================

	class { 'selinux':
		mode => 'disabled'
	}

	service { "iptables":
		ensure => stopped
	}

# ================================================================= 
# MYSQL
# =================================================================
	
	service { "mysqld":
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		require => Package["mysql-server"],
		restart => true
	}
	package { ["mysql-server", "mysql"]: }
	file { "my.cnf":
		owner  => root,
		group  => root,
		mode   => 644,
		path => "/etc/my.cnf",
		source => "puppet:////vagrant/manifests/files/my.cnf",
	}
	file { "mysql-data-init":
		owner  => root,
		group  => root,
		mode   => 644,
		path => "/home/vagrant/test.sql",
		source => "puppet:////vagrant/data/test.sql",
	}
	exec { "db-init":
		command => "/usr/bin/mysql -uroot < /home/vagrant/test.sql > /home/vagrant/data-import.log",
		creates => "/home/vagrant/data-import.log",
		require => Service['mysqld']
	}


# ================================================================= 
# APACHE
# =================================================================

	service { "httpd":
		ensure => running,
		require => Package["httpd"]
	}
	package { "httpd": }
	file { "httpd-conf":
		owner  => root,
		group  => root,
		mode   => 644,
		path => "/etc/httpd/conf.d/httpd-vhosts.conf",
		source => "puppet:////vagrant/manifests/files/httpd-vhosts.conf",
		require => Package["httpd"],
		notify => Service["httpd"]
	}
    
# ================================================================= 
# PHP
# =================================================================

    package { "php": }
	package { "php-devel": }
	package { "php-pear": }
	package { "php-pdo": }
	package { "php-mysql": }
    file { "php-ini":
		path => "/etc/php.d/php.ini",
		source => "puppet:////vagrant/manifests/files/php.ini",
		require => Package["php"]
	}
    exec { "pecl-install-memcache":
		command => 'printf "\n" | pecl install memcache > /home/vagrant/php-memcache-installed.log',
		path =>"/bin:/usr/bin",
		creates => "/home/vagrant/php-memcache-installed.log",
		require => Package["php-devel", "php-pear"]
	}

# ================================================================= 
# MEMCACHE
# =================================================================

    service { "memcached":
		ensure => running,
		require => Package["memcached"]
	}

	package { "memcached": }

}

# Apply it
include website