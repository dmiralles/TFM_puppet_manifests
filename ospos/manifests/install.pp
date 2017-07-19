class ospos::install (
  $install_dir    = '/var/www/html',
  $version        = 'latest',
  $ospos_db_url   = 'puppetagent-mysql.tfm',
  $ospos_db_user  = 'osposuser',
  $ospos_db_pass  = 'ospospass',
  $ospos_db_name  = 'osposdb',
){
  require php
  include apache
  exec {'Download OSPOS package':
    command => "/usr/bin/wget http://puppetagent-subversion.tfm/svn/ospos/opensourcepos-$version.tar.gz",
    cwd     => '/tmp',
  }
  file {'/tmp/ospos':
    ensure => directory,
  }
  exec {'Uncompress OSPOS package':
    command => "/bin/tar zxvf /tmp/opensourcepos-$version.tar.gz",
    cwd     => '/tmp/ospos',
    require => [Exec["Download OSPOS package"],File["/tmp/ospos"]],
  }
  exec {'Copy OSPOS dir into install dir':
    command => "/bin/cp -rfa /tmp/ospos/. $install_dir",
    cwd     => '/tmp',
    require => [Exec["Uncompress OSPOS package"],File["/tmp/ospos"]],
  }
  file {"$install_dir/application/config/database.php":
    ensure  => present,
    content => template("ospos/database.php.erb"),
    require => Exec["Copy OSPOS dir into install dir"],
  }
  file { "$install_dir/.htaccess":
        mode    => "0644",
        replace => "true",
        source  => 'puppet:///modules/ospos/.htaccess_root',
        require => File["$install_dir/application/config/database.php"],
  }
  file { "$install_dir/public/.htaccess":
        mode    => "0644",
        replace => "true",
        source  => 'puppet:///modules/ospos/.htaccess_public',
        require => File["$install_dir/.htaccess"],
  }
  file {"/etc/apache2/apache2.conf":
        ensure  => present,
        replace => "true",
        content => template("ospos/apache2.conf.erb"),
        require => Class["apache"],
  }
  file {"$install_dir/public":
        owner   => 'www-data',
        group   => 'www-data',
        mode    => '0755',
        recurse => true,
        require => Exec["Copy OSPOS dir into install dir"],
  }
  exec {'restart apache':
    command => "/bin/systemctl restart apache2",
    require => [File["/etc/apache2/apache2.conf"],File["$install_dir/public"]],
  }
}
