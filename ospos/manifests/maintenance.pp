class ospos::maintenance {
  file {'/tmp/ospos':
        ensure  => absent,
  }
  file {'/tmp/opensourcepos-$version.tar.gz':
        ensure  => absent,       
  }
}
