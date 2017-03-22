class nginx {

  case $::osfamily {
    'RedHat': {
        $runas = "nginx"
        $logfile = "/var/log/nginx"
        $owner =  "root"
        $group =  "root"
    }
    'Debian': {
        $runas = "www-data"
        $logfile = "/var/log/nginx"
        $owner =  "root"
        $group =  "root"    }
  }
  
  File {
    owner =>  $root,
    group =>  $root,
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
    content  => epp('nginx/nginx.conf.epp', { runas => $runas, logfile => $logifile,})

  }
  
  file { '/etc/nginx/conf.d':
    ensure => directory,
  }
  
  file { '/etc/nginx/conf.d/default.conf':
    ensure  => file,
    require => Package['nginx'],
    notify  => Service['nginx'],
    content  => epp('nginx/default.conf.epp', { runas => $runas, logfile => $logifile,})
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
