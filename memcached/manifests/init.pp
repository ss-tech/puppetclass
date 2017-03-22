
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
    requires => Package['memcached'],
  }
  service { 'memcache':
    ensure => running,
    enable => true,
    subscribes => File['/etc/sysconfig/memcached'],
  }
}
