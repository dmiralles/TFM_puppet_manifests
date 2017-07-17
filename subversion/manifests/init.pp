class subversion (
        $svn_dir  = '/opt/subversion',
        $svnuser  = 'svn',
        $svngroup = 'svn', 
  ){
  require apache
  group { "$svngroup":
        ensure => present,
  }
  user { "$svnuser":
        ensure => present,
        groups => "$svngroup",
  }
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
    owner  => "$svnuser",
    group  => "$svngroup",
    recurse => true,
    require => [Package["subversion"],Package["libapache2-svn"],Package["libapache2-mod-svn"],Package["libsvn-dev"]],
  }
  file {"$svn_dir/conf/svnserve.conf":
          ensure  => present,
          replace => true,
          owner  => "$svnuser",
          group  => "$svngroup",
          mode   => "0755",
          source  => 'puppet:///modules/subversion/svnserve.conf',
          require => [File["$svn_dir"],Exec["Create Repository"]],
  }
  exec { "Create Repository":
          command => "/usr/bin/svnadmin create $svn_dir",
          cwd     => "/tmp",
          require => File["$svn_dir"],
  }
  exec { "Subversion as daemon":
          command => "/usr/bin/svnserve -d --listen-port 3908 --listen-host 0.0.0.0 -r /opt/subversion",
          require => [File["$svn_dir/conf/svnserve.conf"], Exec["Create Repository"]],
  }
  exec { "Enable a2enmod":
          command => "/usr/sbin/a2enmod dav_svn",
          cwd     => "/tmp",
          require => Exec["Subversion as daemon"],
  }
  file {"/etc/apache2/mods-available/dav_svn.conf":
          ensure  => present,
          replace => true,
          owner  => "$svnuser",
          group  => "$svngroup",
          content => template("subversion/dav_svn.conf.erb"),
          require => Exec["Enable a2enmod"],
  }
  file {"/tmp/initial_script.sh":
          ensure  => present,
          replace => true,
          source  => 'puppet:///modules/subversion/initial_script.sh',
          require => File["/etc/apache2/mods-available/dav_svn.conf"],
  }
  exec { "Initial script":
          command => "/bin/sh initial_script.sh",
          cwd     => "/tmp",
          require => [Exec["Subversion as daemon"],File["/tmp/initial_script.sh"]],
  }
  exec { "Restart Apache":
          command => "/bin/systemctl restart apache2",
          require => [File["/etc/apache2/mods-available/dav_svn.conf"],Exec["Initial script"]],
  }
}
