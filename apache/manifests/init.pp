class apache {
  package { 'apache2':
    ensure  => present,
  }
  service { 'apache2':
    ensure  => running,
    require => Package["apache2"],
  }
  file {'/var/www/html/index.html':
    ensure => absent,
    require => Package["apache2"],
  }
  exec {'Enable Rewrite':
    command => '/usr/sbin/a2enmod rewrite',
    notify  => Service['apache2'], 
    require => [Package['apache2'],File['/var/www/html/index.html']],
  }
}
