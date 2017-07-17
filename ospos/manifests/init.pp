class ospos (
  $install_dir    = '/var/www/html',
  $version        = 'latest',
  $ospos_db_url   = 'puppetagent-mysql.tfm',
  $ospos_db_user  = 'osposuser',
  $ospos_db_pass  = 'ospospass',
  $ospos_db_name  = 'osposdb',
){
  include php
  include apache
  exec {'Download OSPOS package':
    command => "/usr/bin/wget http://puppetagent-subversion.tfm/svn/ospos/opensourcepos-$version.tar.gz",
    cwd     => '/tmp',
  }
  exec {'Uncompress OSPOS package':
    command => "/bin/tar zxvf opensourcepos-$version.tar.gz",
    cwd     => '/tmp/ospos',
    require => Exec["Download OSPOS package"],
  }
  file {'/tmp/ospos':
    ensure => directory,
  }
  exec {'Copy OSPOS dir into install dir':
    command => "/bin/cp -a /tmp/ospos/. $install_dir",
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
        require => Exec["Copy OSPOS dir into install dir"],
  }
  file { "$install_dir/public/.htaccess":
        mode    => "0644",
        replace => "true",
        source  => 'puppet:///modules/ospos/.htaccess_public',
        require => Exec["Copy OSPOS dir into install dir"],
  }
}
