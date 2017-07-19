class mysql {
        class{'mysql::install':}->
        class{'mysql::config':}->
        class{'mysql::custom':}->
        class{'mysql::service':}
}
