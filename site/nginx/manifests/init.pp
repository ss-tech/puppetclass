class nginx {
  $packageName  = $facts['os']['family'] ? {
    'Debian'  => 'nginx',
    'RedHat'  => 'nginx',
    'Windows' => 'nginx-service',
  }
  $fileOwner  = $facts['os']['family'] ? {
    'Debian'  => 'root',
    'RedHat'  => 'root',
    'Windows' => 'Administrator',
  }
  $fileGroup= $facts['os']['family'] ? {
    'Debian'  => 'root',
    'RedHat'  => 'root',
    'Windows' => 'Administrators',
  }
  $documentRoot= $facts['os']['family'] ? {
    'Debian'  => '/var/www',
    'RedHat'  => '/var/www',
    'Windows' => 'C:/ProgramData/nginx/html',
  }
  $configDirectory= $facts['os']['family'] ? {
    'Debian'  => '/etc/nginx',
    'RedHat'  => '/etc/nginx',
    'Windows' => 'C:/ProgramData/nginx',
  }
  $serverBlockDirectory= $facts['os']['family'] ? {
    'Debian'  => '/etc/nginx/conf.d',
    'RedHat'  => '/etc/nginx/conf.d',
    'Windows' => 'C:/ProgramData/nginx/conf.d',
  }
  $logsDirectory= $facts['os']['family'] ? {
    'Debian'  => '/var/log/nginx',
    'RedHat'  => '/var/log/nginx',
    'Windows' => 'C:/ProgramData/nginx/logs',
  }
  $serviceName= $facts['os']['family'] ? {
    'Debian'  => 'nginx',
    'RedHat'  => 'nginx',
    'Windows' => 'nginx',
  }
  $runas= $facts['os']['family'] ? {
    'Debian'  => 'www-data',
    'RedHat'  => 'nginx',
    'Windows' => 'nobody',
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
