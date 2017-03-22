class memcached {
  # package
  package { 'memcached':
    ensure => latest,
  }

  # file
  file { 'memcached.conf':
    ensure  => file,
    path    => '/etc/sysconfig/memcached',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/memcached/memcached',
    require => Package['memcached'],
    notify  => Service['memcached'],
  }

  # service
  service { 'memcached':
    ensure  => running,
    enable  => true,
  }
}
