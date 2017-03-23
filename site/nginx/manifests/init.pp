class nginx (
  $root = undef,
){
case $facts['os']['name'] {
  'redhat','debian' : {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
#      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $logdir = '/var/log/nginx'
      $default_docroot ='/var/www'
      }
  'windows' : {
    $package = 'nginx-service'
    $owner = 'Administrator'
    $group = 'Administrators'
#    $docroot = 'C:/ProgramData/nginx/html'
    $confdir = 'C:/ProgramData/nginx'
    $logdir = 'C:/ProgramData/nginx/logs'
    $default_docroot = 'C:/ProgramData/nginx/html'
    }
  default : {
    fail("Module ${module_name} is not supported on ${facts['os']['family']}") }
    }
}
$user = $facts['os']['family'] ? {
  'redhat' => 'nginx',
  'debian' => 'www-data',
  'windows' => 'nobody',
  }
$port = '80'
$docroot = $root ? {
undef => $default_docroot,
default => $root,
}
  package { $package:
    ensure => present,
  }
  File { 
    owner  => $owner,
    group  => $group,
    mode   => '0664',
    }
  file { $docroot:
    ensure => directory,
    mode   => '0775',
  }
  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  file { '$confdir/nginx.conf':
    ensure  => file,
    content => epp('nginx/nginx.conf.epp',
      {
        user => $user,
        confdir => $confdir,
        logdir => $logdir,
      }),
    notify => Service['nginx'],
    }
  file { '$confdir/conf.d':
    ensure => directory,
    mode   => '0775',
  }
  file { '/etc/nginx/conf.d/default.conf':
    ensure  => file,
    content => epp('nginx/default.conf.epp',
      {
       port => $port,
       docroot => $docroot,
      }),
    notify  => Service['nginx'],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
