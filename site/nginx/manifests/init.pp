class nginx (
  String $root,
) {

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
