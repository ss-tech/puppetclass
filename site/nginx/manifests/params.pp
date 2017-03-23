class nginx::params {
case $facts['os']['family'] {
    'RedHat': {
      $nginx_packagename = 'nginx'
      $nginx_owner = 'root'
      $nginx_group = 'root'
      $nginx_rootdir = '/var/www'
      $nginx_confdir = '/etc/nginx'
      $nginx_logdir = '/var/log/nginx'
      $nginx_servicename = 'nginx'
      $nginx_user = 'nginx'
    }
    'Debian': {
      $nginx_packagename = 'nginx'
      $nginx_owner = 'root'
      $nginx_group = 'root'
      $nginx_rootdir = '/var/www'
      $nginx_confdir = '/etc/nginx'
      $nginx_logdir = '/var/log/nginx'
      $nginx_servicename = 'nginx'
      $nginx_user = 'www-data'    
    }
    'Windows': {
      $nginx_packagename = 'nginx-service'
      $nginx_owner = 'Administrator'
      $nginx_group = 'Administrators'
      $nginx_rootdir = 'C:/ProgramData/nginx/html'
      $nginx_confdir = 'C:/ProgramData/nginx'
      $nginx_logdir = 'C:/ProgramData/nginx/logs'
      $nginx_servicename = 'nginx'
      $nginx_user = 'nobody'   
    }
    default: {
      $nginx_packagename = 'nginx'
      $nginx_owner = 'root'
      $nginx_group = 'root'
      $nginx_rootdir = '/var/www'
      $nginx_confdir = '/etc/nginx'
      $nginx_logdir = '/var/log/nginx'
      $nginx_servicename = 'nginx'
      $nginx_user = 'nginx'
    }
  }
}
