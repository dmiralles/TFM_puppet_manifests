class subversion (
        $svn_dir = '/opt/subversion'
  ){
  package { 'subversion':
    ensure  => present,
  }
  package { 'libapache2-svn':
    ensure  => present,
  }
  package { 'libapache2-mod-svn':
    ensure  => present,
  }
  package { 'libsvn-dev':
    ensure  => present,
  }
  file {"$svn_dir":
    ensure => 'directory',
    recurse => true,
    require => [Package["subversion"],Package["libapache2-svn"],Package["libapache2-mod-svn"],Package["libsvn-dev"]],
  }
  exec { "Create Repository":
          command => "/usr/bin/svnadmin create $svn_dir",
          cwd     => "/tmp",
          require => File["$svn_dir"],
  }
  exec { "Create Repository":
          command => "/usr/bin/a2enmod dav_svn",
          cwd     => "/tmp",
          require => File["Create Repository"],
  }
}
