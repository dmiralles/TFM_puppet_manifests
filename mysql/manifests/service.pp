class mysql::service {
        service {'mysql':
                ensure  => running,
                enable  => true,
        }
}
