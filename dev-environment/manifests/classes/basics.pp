# Change out the sources.list
class update_sources {
    file { 
        "/etc/apt/sources.list":
            ensure => file,
            source => "/vagrant/configs/apt/sources.list",
            owner => "vagrant", group => "vagrant", mode => 0644;
    }
}

# Make sure the repos get updated
class update_repos {
    exec { "apt-update":
        command => '/usr/bin/apt-get update'
    }
}

# Redirect webroot
class link_webroot {
    file { "/var/www":
      ensure  => "link",
      target  => "/vagrant/www",
      require => Package["apache2"],
      notify  => Service["apache2"],
      force   => true,
    }
}

# Get apache up and running
class apache {
    package { [ "apache2" ]:
        ensure => latest,
    }
}

# Get mysql up and running
class mysql {
    package { [ "mysql-server", "mysql-client" ]:
        ensure => latest,
    }
}

# Get php up and running
class php {
    package { [ "php5", "php-pear", "php5-mysql", "php5-curl", "php5-imagick", "php5-gd", "php5-mcrypt" ]:
        ensure => latest,
    }
}

# Update hosts file
class update_hosts {
    file { "/etc/hosts":
        source => "/vagrant/configs/system/hosts"
    }
}

