# package
package { 'memcached':
  ensure => latest,
}

# file
file { '/etc/sysconfig/memcached':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  source  => 'puppet:///modules/memcached/memcached',
  require => Package['memcached'],
  notify  => Service['memcached'],
}

# service
service { 'memcached':
  ensure  => running,
  enable  => true,
}
