class nginx {
  File {
    owner  => 'root',
    mode   => '0644',
  }

  package { 'nginx':
    ensure => present,
  }
  file { '/var/www':
    ensure => directory,
    group  => 'root',
  }
  file { '/var/www/index.html':
    ensure => file,
    group  => 'root',
    source => 'puppet:///modules/nginx/index.html',
  }
  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    group   => 'root',
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  file { '/etc/nginx/conf.d':
    ensure => directory,
    group  => 'root',
  }
  file { '/etc/nginx/conf.d/default.conf':
    ensure  => file,
    group   => 'root',
    source  => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}