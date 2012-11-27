class common {
	
	file { "/root/common.sh":
		owner  => root,
		group  => root,
		mode   => 755,
		source => "puppet:////vagrant/manifests/files/common.sh"
	}

	exec { 'yum-update':
	    command => '/usr/bin/yum -y update'
	}

	exec { "common":
		command => "/bin/bash /root/common.sh",
		cwd => "/root",
		user => root,
		require => File["/root/common.sh"]
	}

	service { "iptables":
		ensure => stopped
	}

	Exec {
		path => ["/usr/bin", "/bin"]
	}

	File {
		owner => root,
		group => root,
		mode => 644,
	}

	exec { "yum-clean-all":
		command => "/usr/bin/yum clean all",
		cwd => "/root"
	}

}

class webserver {
	Package {
		ensure => "installed"
	}

	service { "httpd":
		ensure => running,
		require => Package["httpd"]
	}

	service { "memcached":
		ensure => running,
		require => Package["memcached"]
	}

	package { "memcached": }
	package { "httpd": }
	package { ["mysql-server", "mysql"]: }
	package { "php": }
	package { "php-devel": }
	package { "php-pear": }
	package { "php-pdo": }
	package { "php-mysql": }

	service { "mysqld":
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		require => Package["mysql-server"],
		restart => true,
		subscribe => File['mysql-conf']
	}

	file { "php-ini":
		path => "/etc/php.d/php.ini",
		source => "puppet:////vagrant/manifests/files/php.ini",
		require => Package["php"]
	}

	file { "httpd-conf":
		owner  => root,
		group  => root,
		mode   => 644,
		path => "/etc/httpd/conf.d/httpd-vhosts.conf",
		source => "puppet:////vagrant/manifests/files/httpd-vhosts.conf",
		require => Package["httpd"],
		notify => Service["httpd"]
	}

	file { "mysql-conf":
		path => "/etc/my.cnf",
		source => "puppet:////vagrant/manifests/files/my.cnf",
		require => Package["mysql-server"]
	}

	file { "sql-grants":
		path => "/home/vagrant/grants.sql",
		source => "puppet:////vagrant/manifests/files/grants.sql",
		require => Package["mysql-server"]
	}

	file { "mysql-data-init":
		path => "/home/vagrant/data.sql",
		source => "puppet:////vagrant/manifests/files/data.sql",
		require => Package["mysql-server"]
	}

	exec { "pecl-install-memcache":
		command => 'printf "\n" | pecl install memcache',
		path =>"/bin:/usr/bin",
		require => Package["php-devel", "php-pear"]
	}
}

class mysqlexecs {
	exec { "db-init":
		command => "mysql -uroot < /home/vagrant/data.sql",
		path =>"/bin:/usr/bin"
	}

	exec { "mysql-permissions":
		command => "mysql -uroot < /home/vagrant/grants.sql",
		path => "/bin:/usr/bin"
	}
}
stage { mysqlexecs: }


stage { pre: before => Stage[main] }
class { common: stage => pre }

stage { webstart: before => Stage[mysqlexecs] }
class { webserver: stage => webstart }

include common
include webserver	
include mysqlexecs	
	