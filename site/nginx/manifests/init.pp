class nginx (
  String $root = undef,
) {
#Defaults and Variables
  case $facts['os']['family'] {
    'RedHat': {
      $nginx_packagename = 'nginx'
      $nginx_owner = 'root'
      $nginx_group = 'root'
      $nginx_rootdir = '/var/www'
      $nginx_confdir = '/etc/nginx'
      $nginx_logdir = '/var/log/nginx'
      $nginx_servicename = 'nginx'
      $nginx_user = 'nginx'
    }
    'Debian': {
      $nginx_packagename = 'nginx'
      $nginx_owner = 'root'
      $nginx_group = 'root'
      $nginx_rootdir = '/var/www'
      $nginx_confdir = '/etc/nginx'
      $nginx_logdir = '/var/log/nginx'
      $nginx_servicename = 'nginx'
      $nginx_user = 'www-data'    
    }
    'Windows': {
      $nginx_packagename = 'nginx-service'
      $nginx_owner = 'Administrator'
      $nginx_group = 'Administrators'
      $nginx_rootdir = 'C:/ProgramData/nginx/html'
      $nginx_confdir = 'C:/ProgramData/nginx'
      $nginx_logdir = 'C:/ProgramData/nginx/logs'
      $nginx_servicename = 'nginx'
      $nginx_user = 'nobody'   
    }
    default: {
      $nginx_packagename = 'nginx'
      $nginx_owner = 'root'
      $nginx_group = 'root'
      $nginx_rootdir = '/var/www'
      $nginx_confdir = '/etc/nginx'
      $nginx_logdir = '/var/log/nginx'
      $nginx_servicename = 'nginx'
      $nginx_user = 'nginx'
    }
  }
  File {
    owner => "${nginx_owner}",
    group => "${nginx_group}",
    mode  => '0644',
  }
  $docroot = $root ? {
    undef => $nginx_rootdir,
    default => $root,
  }
#Do the work  
  package { 'nginx':
    ensure => present,
    name => "${nginx_packagename}",
  }
  file { [ "${docroot}/", "${nginx_confdir}/conf.d" ]:
    ensure => directory,
  }
  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  file { "${nginx_confdir}/nginx.conf":
    ensure  => file,
    content => epp('nginx/nginx.conf.epp'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  file { "${nginx_confdir}/conf.d/default.conf":
    ensure  => file,
    content => epp('nginx/default.conf.epp'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
    name => "${nginx_servicename}",
  }
}
