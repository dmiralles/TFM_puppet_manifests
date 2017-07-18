class mysql::install {
        package { 'mysql-server':
                ensure  => present,
        }
        package { 'mysql-common':
                ensure  => present,
        }
        package { 'python-mysqldb':
                ensure  => present,
        }
}
