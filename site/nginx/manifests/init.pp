class nginx (
  $root = undef,
  $packageName  = $nginx::params::packageName,
  $fileOwner    = $nginx::params::fileOwner,
  $fileGroup    = $nginx::params::fileGroup,
  $default_documentRoot = $nginx::params::default_documentRoot,
  $configDirectory  = $nginx::params::configDirectory,
  $serverBlockDirectory = $nginx::params::serverBlockDirectory,
  $logsDirectory  = $nginx::params::logsDirectory,
  $serviceName  = $nginx::params::serviceName,
  $runas  = $nginx::params::runas,
)

inherits nginx::params

{
  $documentRoot = $root ? {
    undef   => $default_documentRoot,
    default => $root,
  }
  package { 'nginx':
    ensure => present,
  }
  File {
    owner => $fileOwner,
    group => $fileGroup,
    mode  => '0644',
  }
  file { "${documentRoot}":
    ensure => directory,
  }
  file { "${documentRoot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  file { "${configDirectory}/nginx.conf":
    ensure  => file,
    content  => epp('nginx/nginx.conf.epp',
    {
      runas                => $runas,
      logsDirectory        => $logsDirectory,
      configDirectory      => $configDirectory,
      serverBlockDirectory => $serverBlockDirectory,
    }),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  file { "${configDirectory}":
    ensure => directory,
  }
  file { "${serverBlockDirectory}":
    ensure => directory,
  }
  file { "${serverBlockDirectory}/default.conf":
    ensure         => file,
    content        => epp('nginx/default.conf.epp',{
      documentRoot => $documentRoot,
    }),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  service { "${serviceName}":
    ensure => running,
    enable => true,
  }
}
