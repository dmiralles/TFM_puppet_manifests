class nginx {
        package { 'nginx':
                ensure  => present,
        }
        service {'nginx':
                ensure => running,
                require => Package['nginx'],
        }
        file {'/etc/nginx/sites-available/nginx.conf':
                ensure  => present,
                replace => true,
                source  => 'puppet:///modules/nginx/default',
                require => Package["nginx"],
                notify  => Service["nginx"], 
        }
}
