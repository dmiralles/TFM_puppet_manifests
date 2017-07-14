class php {
        package {'php5.6':
                ensure => present,
        }
        package {'php5.6-mysql':
                ensure => present,
        }
        package {'libapache2-mod-php5.6':
                ensure => present,
        }
        package {'php5.6-mcrypt':
                ensure => present,
        }
}
