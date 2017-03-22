class skeleton{
  file { '/etc/skel':
    ensure => 'directory',
    group  => 'root',
    owner  => 'root',
    type   => 'directory',
  }
  file { '/etc/skel/.bashrc':
    ensure  => 'file',
    group   => 'root',
    owner   => 'root',
    source => 'puppet:///modules/skeleton/bashrc'
  }
}
