class nginx::params{
  $nginx_index_file = 'index.html'
  $nginx_conf_file = 'nginx.conf'
  $nginx_default_file = 'default.conf'
  
  case $facts['os']['family'] {
    'debian': {
      $nginx_package_name = 'nginx'
      $nginx_owner = 'root'
      $nginx_group = 'root'
      $nginx_www_dir = '/var/www'
      $nginx_conf_root_dir = '/etc/nginx'
      $nginx_conf_incl_dir = '/etc/nginx/conf.d'
      $nginx_log_dir = '/var/log/nginx'
      $nginx_service = 'nginx'
      $nginx_service_account = 'www-data'
    }
    'redhat': {
      $nginx_package_name = 'nginx'
      $nginx_owner = 'root'
      $nginx_group = 'root'
      $nginx_www_dir = '/var/www'
      $nginx_conf_root_dir = '/etc/nginx'
      $nginx_conf_incl_dir = '/etc/nginx/conf.d'
      $nginx_log_dir = '/var/log/nginx/'
      $nginx_service = 'nginx'
      $nginx_service_account = 'nginx'
    }
    'windows': {
      $nginx_package_name = 'nginx-service'
      $nginx_owner = 'Administrator'
      $nginx_group = 'Administrators'
      $nginx_www_dir = 'C:/ProgramData/nginx/html'
      $nginx_conf_root_dir = 'C:/ProgramData/nginx'
      $nginx_conf_incl_dir = 'C:/ProgramData/nginx/conf.d'
      $nginx_log_dir = 'C:/ProgramData/nginx/logs'
      $nginx_service = 'nginx'
      $nginx_service_account = 'nobody'
    }
    default: {
      fail("Unsupported OS Family ${facts['os']['family']} ")
    }
  }
}
