class sonarqube (
  $install_dir  = '/opt/sonarqube',
  $sonar_db_user = 'sonaruser',
  $sonar_db_pass = 'sonarpass123',
  $sonar_db_url  = 'test',
){
  exec {"add ppa":
    command => "/usr/bin/add-apt-repository ppa:openjdk-r/ppa",
  }
  exec {"apt-get update":
    command => "/usr/bin/apt-get update",
    onlyif  => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
    require => Exec["add ppa"],
  }
  package {'openjdk-8-jre':
    ensure  => present,
    require => Exec["apt-get update"],
  }
  package {'unzip':
    ensure => present,
  }
  exec {'Download SonarQube package':
    command => '/usr/bin/wget https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-6.4.zip',
    cwd     => '/tmp',
    require => Package["openjdk-8-jre"],
  }
  exec {'Uncompress SonarQube package':
    command => "/usr/bin/unzip /tmp/sonarqube-6.4.zip ",
    cwd     => '/tmp',
    require => [Exec["Download SonarQube package"],Package["unzip"]],
  }
  file {"$install_dir":
    ensure  => directory,
    recurse => true,
    require => Exec["Uncompress SonarQube package"],
  }
  exec {'Copy Sonarqube dir into install dir':
    command => "/bin/cp -a /tmp/sonarqube-6.4/. $install_dir",
    cwd     => '/tmp',
    require => [File["$install_dir"],Exec["Uncompress SonarQube package"]],
  }
  file{"$install_dir/conf/sonar.properties":
    ensure  => present,
    content => template("sonarqube/sonar.properties.erb"),
    require => Exec["Copy Sonarqube dir into install dir"],
  }
  exec {'Start Sonarqube':
    command => "/bin/sh $install_dir/bin/linux-x86-64/sonar.sh start",
    require => File["$install_dir/conf/sonar.properties"],
  }
}
