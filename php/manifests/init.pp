class php {
        exec {'Update repos':
                command => '/usr/bin/apt-get update',
        }
        package {'php5':
                ensure  => present,
                require => Exec["Update repos"],
        }
        package {'php5-mysql':
                ensure => present,
                require => Exec["Update repos"],
        }
        package {'libapache2-mod-php5':
                ensure => present,
                require => Exec["Update repos"],
        }
        package {'php5-mcrypt':
                ensure => present,
                require => Exec["Update repos"],
        }
}
