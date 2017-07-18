class mysql::custom {
        exec {'stop-mysql':
                command => '/bin/systemctl stop mysql',
                require => Package['mysql-server','python-mysqldb','mysql-common'],
                notify  => File["/etc/mysql/mysql.conf.d/mysqld.cnf"],
        }
        file {'/etc/mysql/mysql.conf.d/mysqld.cnf':
                mode    => "0644",
                replace => "true",
                source  => 'puppet:///modules/mysql/mysqld.cnf',
        }     
}
