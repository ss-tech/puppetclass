class nginx (
  $nginx_packagename = $nginx::params::nginx_packagename,
  $nginx_owner = $nginx::params::nginx_owner,
  $nginx_group = $nginx::params::nginx_group,
  $nginx_rootdir = $nginx::params::nginx_rootdir,
  $nginx_confdir = $nginx::params::nginx_confdir,
  $nginx_logdir = $nginx::params::nginx_logdir,
  $nginx_servicename = $nginx::params::nginx_servicename,
  $nginx_user = $nginx::params::nginx_user,
) {
  $docroot = $nginx_rootdir
  File {
    owner => "${nginx_owner}",
    group => "${nginx_group}",
    mode  => '0644',
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
