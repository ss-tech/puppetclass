package { 'memcached':
  ensure => present,
}

service { 'memcached':
  ensure  => running,
  enable  => true,
  suscribe => File ['openssh'],
}
file { '/etc/sysconfig/memcached':
  ensure => file,
  source => 'puppet:///modules/memcached/',
}
