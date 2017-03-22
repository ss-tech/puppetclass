
class memcached {
  package { 'memcached':
    ensure => present,
  }
  file { '/etc/sysconfig/memcached':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/memcached/memcached',
    requires => Package['memcached'],
  }
  service { 'memcache':
    subscribes => File['/etc/sysconfig/memcached'],
  }
}
