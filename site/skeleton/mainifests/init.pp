
class skeleton { '':
  file { '/etc/skel/.bashrc'
     ensure => file,
     owner => root,
     mode => 0644,
  }
}
