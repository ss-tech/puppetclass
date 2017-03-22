
class memcached {
  package { 'memcached':
    ensure => latest,
  }
  file { 'memcached.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    path => '/etc/sysconfig/memcached',
    source => 'puppet:///modules/memcached/memcached.conf',
    require => Package['memcached'],
  }
  service { 'memcache':
    ensure => running,
    enable => true,
    subscribe => File['/etc/sysconfig/memcached'],
  }
}
