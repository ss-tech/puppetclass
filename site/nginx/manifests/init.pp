class nginx {

  # Packages
  package { 'nginx':
    ensure => latest,
  }

  # Directories
  file { [ 'nginx.www.root', 'nginx.config.root', 'nginx.config.include' ]:
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755'
    path => [ '/var/www', '/etc/nginx', '/etc/nginx/conf.d' ],
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
  }
  
  file { 'nginx.default.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    path => '/etc/nginx/conf.d/default.conf',
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => File['nginx.config.include'],
  }





  service { 'nginx':
    ensure  => running

  }

}
