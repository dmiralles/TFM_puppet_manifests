class mysql {
        Class["mysql::install"]~>
        Class["mysql::config"]~>
        Class["mysql::custom"]~>
        Class["mysql::service"]
}
