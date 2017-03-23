class nginx (
    $root = "/var/www",
){

  $docroot = $root
  
  case $::osfamily {
    'RedHat': {
        $logfile = "/var/log/nginx/access.log"
        $owner =  "root"
        $group =  "root"
    }
    'Debian': {
        $logfile = "/var/log/nginx/access.log"
        $owner =  "root"
        $group =  "root"    }
  }
  
  $runas = $facts['os']['family'] ? {
    'redhat' => 'nginx',
    'debian' => 'www-data',
  }
  
  
  File {
    owner =>  $owner,
    group =>  $owner,
    mode  => '0644',
  }
  

  
  package { 'nginx':
    ensure => present,
  }
  file { '/var/www':
    ensure => directory,
  }
  
  file { '/var/www/index.html':
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    require => Package['nginx'],
    notify  => Service['nginx'],
    content  => epp('nginx/nginx.conf.epp', { runas => $runas, logfile => $logfile, docroot => $docroot, })

  }
  
  file { '/etc/nginx/conf.d':
    ensure => directory,
  }
  
  file { '/etc/nginx/conf.d/default.conf':
    ensure  => file,
    require => Package['nginx'],
    notify  => Service['nginx'],
    content  => epp('nginx/default.conf.epp', { runas => $runas, logfile => $logfile, docroot => $docroot, })
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
