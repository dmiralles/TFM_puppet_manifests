class php {
        exec {'Update repos':
                command => '/usr/bin/apt-get update',
        }
        package {'php5.6':
                ensure  => present,
                require => Exec["Update repos"],
        }
        package {'php5.6-mysql':
                ensure => present,
                require => Exec["Update repos"],
        }
        package {'libapache2-mod-php5.6':
                ensure => present,
                require => Exec["Update repos"],
        }
        package {'php5.6-mcrypt':
                ensure => present,
                require => Exec["Update repos"],
        }
}
