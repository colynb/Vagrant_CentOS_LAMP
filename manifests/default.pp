class common {
	
	file { "/root/common.sh":
		owner  => root,
		group  => root,
		mode   => 755,
		source => "puppet:////vagrant/manifests/files/common.sh"
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

	package { "httpd": }
	package { ["mysql-server", "mysql"]: }
	package { "memcached": }
	package { "php": }
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

	file { "mysql-conf":
		path => "/etc/my.cnf",
		source => "puppet:////vagrant/manifests/files/my.cnf",
		require => Package["mysql-server"]
	}

	file { "/home/vagrant/grants.sql":
		source => "puppet:////vagrant/manifests/files/grants.sql",
		require => Package["mysql-server"]
	}

	file { "/home/vagrant/data.sql":
		source => "puppet:////vagrant/manifests/files/data.sql",
		require => Package["mysql-server"]
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
	