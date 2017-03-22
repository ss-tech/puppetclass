class nginx {
  case $facts['os']['family'] {
    'redhat','debian' : {
      $package   = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docRoot   = '/var/www'
      $configDir = '/etc/nginx'
      $logDir    = '/var/log/nginx'
    }
    'windows' : {
      $package   = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docRoot   = '/var/www'
      $configDir = '/etc/nginx'
      $logDir    = '/var/log/nginx'
    }
  }
  
  $user = $facts['os']['family'] ? {
    'redhat'  = 'nginx',
    'debian'  = 'www-data',
    'windows' = 'nobody',
  }
    
  File {
    owner  => $owner,
    group  => $group,
    mode   => '0664',
  }
  
  package { $package:
    ensure => present,
    alias  => 'nginx'
  }
  file { [ $docRoot, "${configDir}/conf.d" ] :
    ensure => directory,
  }
  file { "${$docRoot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  file { "${configDir}/nginx.conf":
    ensure  => file,
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  file { "${configDir}/conf.d/default.conf":
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
