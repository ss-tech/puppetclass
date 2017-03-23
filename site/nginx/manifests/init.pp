class nginx (
  $package = $nginx::params::package,
  $owner = $nginx::params::owner,
  $group = $nginx::params::group,
  $docroot = $nginx::params::docroot,
  $confdir = $nginx::params::confdir,
  $logdir = $nginx::params::logdir,
  $user = $nginx::params::user,
  $port = $nginx::params::port,
) inherits nginx::params {
  File {
    owner => $owner,
    group => $group,
    mode => '0644',
  }
  package { $package:
    ensure => present,
  }
  file { [$docroot, "${confdir}/conf.d"]:
    ensure => directory,
  }
  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  file { "${confdir}/nginx.conf":
    ensure  => file,
    content => epp('nginx/nginx.conf.epp',
    {
      user => $user,
      confdir => $confdir,
      logdir => $logdir,
    }),
    require => Package['nginx'],
  }
  file { "${confdir}/conf.d/default.conf":
    ensure  => file,
    content => epp('nginx/default.conf.epp',
    {
      docroot => $docroot,
      port => $port,
    }),
    require => Package['nginx'],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => [File['/etc/nginx/conf.d/default.conf'], File['/etc/nginx/nginx.conf']],
  }
}
