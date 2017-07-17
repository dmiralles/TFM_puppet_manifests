class php {
        exec {'Get php5':
                command => '/usr/bin/add-apt-repository ppa:ondrej/php',
        }
        exec {'Update repos':
                command => '/usr/bin/apt-get update',
                require => Exec["Get php5"],
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
