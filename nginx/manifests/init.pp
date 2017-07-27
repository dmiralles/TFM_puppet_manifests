class nginx {
        package { 'nginx':
                ensure  => present,
        }
        service {'nginx':
                ensure => running,
                require => Package['nginx'],
        }
        file {'/etc/nginx/sites-available/default':
                ensure  => present,
                source  => 'puppet:///modules/nginx/default',
                require => [Service["nginx"],Package["nginx"]],
                notify  => Service["nginx"], 
        }
}