class skeleton {
  file { '/etc/skel':
    ensure => directory
    owner  => 'root'
    group  => 'root'
  }
  file { '/etc/skel/.bashrc':
    ensure  => file
    owner   => 'root'
    group   => 'root'
    source  => 'puppet:///modules/skeleton/files/.bashrc'
    content => "This is just an example bashrc file that does nothing"
  }
}

