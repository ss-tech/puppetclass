class nginx {

  # Packages
  package { 'nginx':
    ensure => latest,
  }

  # Directories
  file { 'nginx.www.root':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755'
    path => '/var/www',
  }
  
  file { 'nginx.config.root':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755'
    path => '/etc/nginx',
  }
  
  file { 'nginx.config.include' :
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755'
    path => '/etc/nginx/conf.d,
  }
  
  # Files
  file { 'nginx.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    path => '/etc/nginx/nginx.conf',
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => File['nginx.config.root'],
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  
  file { 'nginx.default.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    path => '/etc/nginx/conf.d/default.conf',
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => File['nginx.config.include'],
    notify => Service['nginx'],
  }





  service { 'nginx':
    ensure  => running
    enable    => true,
  }
}
