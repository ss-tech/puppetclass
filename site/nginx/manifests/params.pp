class nginx::params {
  case $facts['os']['family'] {
    'redhat','debian' : {
      $package   = 'nginx'
      $owner = 'root'
      $group = 'root'
      $root = '/var/www'
      $confdir = '/etc/nginx'
      $logdir    = '/var/log/nginx'
    }
    'windows' : {
      $package   = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administrators'
      $root = 'C:/ProgramData/nginx/html'
      $confdir = 'C:/ProgramData/ngingx'
      $logdir    = 'C:/ProgramData/ngingx/logs'
    }
    default : {
      fail("Module ${module_name} is not supported on $facts['os']['family']")
    }
  }
  
  $user = $facts['os']['family'] ? {
    'redhat'  => 'nginx',
    'debian'  => 'www-data',
    'windows' => 'nobody',
  }
}
