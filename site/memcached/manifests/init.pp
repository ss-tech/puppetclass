class memcached {
package { 'memcached': 
  ensure => present,
  }
file { '/etc/systemconfig/memcached':
  ensure => file,
  owner => 'root',
  group => 'root',
  mode => '0777',
  content => 'puppet:///modules/memcached/memcached.conf',
  require => Package['memcached'],
  }
service { 'memcached':
  ensure => running,
  enable => true,
  subscribe => File['memcached'],
  }
}
