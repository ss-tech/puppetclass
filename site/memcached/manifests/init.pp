class memcached {

  package { 'memcached':
    ensure => present,
  }

  file { '/etc/sysconfig/memcached':
    owner   => 'memcached',
    ensure  => file,
    group   => 'memcached',
    mode    => '0655',
    source  => 'puppet:///modules/memcached/conf',
    require =>  Package['memcached'],
  }

  service { 'memcached':
    ensure    =>  running,
    enable    =>  true,
    subscribe => File['/etc/sysconfig/memcached'],
  }

}
