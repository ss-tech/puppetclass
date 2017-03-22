class skeleton {
file { '/etc/skel':
  ensure => 'directory',
  group  => '0',
  mode   => '0777',
  owner  => '0',
  }
file { '/etc/skel/.bashrc': 
  ensure => file,
  content => 'puppet:///modules/skeleton/.bashrc',
  }
}
