class ospos::maintenance(
  $version = 'latest',
){
  Exec {'Remove working path':
        command => '/bin/rm -rf /tmp/ospos',
  }
  file {'Remove previous package':
        command => '/bin/rm -rf /tmp/opensourcepos-$version.tar.gz'.       
  }
}
