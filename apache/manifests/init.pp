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
}
