# 
# Configure everything necessary for the site.
#

define apache::loadmodule () {
     exec { "/usr/sbin/a2enmod $name" :
          unless => "/bin/readlink -e /etc/apache2/mods-enabled/${name}.load",
          notify => Service[apache2]
     }
}

class apache_config {
    apache::loadmodule { "env": }
    apache::loadmodule { "setenvif": }
    apache::loadmodule { "headers": }
    apache::loadmodule { "expires": }
    apache::loadmodule { "alias": }
    apache::loadmodule { "rewrite": }
    apache::loadmodule { "proxy": }
    apache::loadmodule { "proxy_http": 
        require => Apache::Loadmodule['proxy']
    }
    apache::loadmodule { "vhost_alias": }

    file { "/etc/apache2/sites-enabled/default.conf":
        source => "/vagrant/configs/apache2/default.conf",
        require => [
            Package['apache2'],
            Apache::Loadmodule['env'],
            Apache::Loadmodule['setenvif'],
            Apache::Loadmodule['headers'],
            Apache::Loadmodule['expires'],
            Apache::Loadmodule['alias'],
            Apache::Loadmodule['rewrite'],
            Apache::Loadmodule['proxy'],
            Apache::Loadmodule['proxy_http'],
            Apache::Loadmodule['vhost_alias'],
        ];
    }
    file { "/etc/php5/apache2/php.ini":
        source => "/vagrant/configs/php/php.ini",
        require => [
            Package['apache2'],
            Package['php5']
        ];
    }

    service { "apache2":
        ensure    => running,
        enable    => true,
        require   => [ Package['apache2'], ],
        subscribe => [ File['/etc/apache2/sites-enabled/default.conf'], File['/etc/php5/apache2/php.ini'] ]
    }
}

class mysql_config {
    file { 
        "/etc/mysql/my.cnf":
            source => "/vagrant/configs/mysql/my.cnf",
            owner => "root", group => "root", mode => 0644;
        "/tmp/init.sql":
            ensure => file,
            source => "/vagrant/configs/mysql/init.sql",
            owner => "vagrant", group => "vagrant", mode => 0644;
    }
    service { "mysql": 
        ensure => running, 
        enable => true, 
        require => [ Package['mysql-server'], File["/etc/mysql/my.cnf"] ],
        subscribe => [ File["/etc/mysql/my.cnf"] ]
    }
    exec { 
        "setup_mysql_databases_and_users":
            command => "/usr/bin/mysql -uroot < /tmp/init.sql",
            require => [ 
                File["/tmp/init.sql"],
                Service["mysql"] 
            ];
    }
    
}

class site_config {
    include apache_config, mysql_config
    Class[apache_config] -> Class[mysql_config]
}