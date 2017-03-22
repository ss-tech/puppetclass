class nginx {

  $nginx_www_dir = '/var/www'
  $nginx_conf_root_dir = '/etc/nginx'
  $nginx_conf_incl_dir = '/etc/nginx/conf.d'


  File {
    owner => 'root',
    group => 'root',
    mode => '0664'
  }


  package { 'nginx':
    ensure => present,
  }
  file { [ $nginx_www_dir, $nginx_conf_root_dir, $nginx_conf_incl_dir ]:
    ensure => directory,
  }
  file { '/var/www/index.html':
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  file { '/etc/nginx/conf.d/default.conf':
    ensure  => file,
    source  => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
