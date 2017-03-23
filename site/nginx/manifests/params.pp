class nginx::params{
  $index_file = 'index.html'
  $conf_file = 'nginx.conf'
  $default_file = 'default.conf'
  
  case $facts['os']['family'] {
    'debian','redhat: {
      $package_name = 'nginx'
      $owner = 'root'
      $group = 'root'
      $www_dir = '/var/www'
      $conf_root_dir = '/etc/nginx'
      $conf_incl_dir = '/etc/nginx/conf.d'
      $log_dir = '/var/log/nginx'
      $service = 'nginx'
    }
    'windows': {
      $package_name = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administrators'
      $www_dir = 'C:/ProgramData/nginx/html'
      $conf_root_dir = 'C:/ProgramData/nginx'
      $conf_incl_dir = 'C:/ProgramData/nginx/conf.d'
      $log_dir = 'C:/ProgramData/nginx/logs'
      $service = 'nginx'
    }
    default: {
      fail("Unsupported OS Family ${facts['os']['family']} ")
    }
  }
  case $facts['os']['family'] { 
    'debian': {
      $service_account = 'debian-account'
    }
    'redhat': {
      $service_account = 'nginx'
    }
    'windows': {
      $service_account = 'nobody'
    }
    default: {
      fail("Unsupported OS Family ${facts['os']['family']} ")
    }
  }
}
