class php {
        package {'php7.0':
                ensure => present,
        }
        package {'php7.0-mysql':
                ensure => present,
        }
        package {'libapache2-mod-php7.0':
                ensure => present,
        }
        package {'php7.0-mcrypt':
                ensure => present,
        }
}
