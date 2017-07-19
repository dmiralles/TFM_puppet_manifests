class ospos::maintenance(
  $version = 'latest',
){
  exec {'Remove working path':
        command => '/bin/rm -rf /tmp/ospos',
  }
  exec {'Remove previous package':
        command => "/bin/rm -rf /tmp/opensourcepos-$version.tar.gz",      
  }
}
