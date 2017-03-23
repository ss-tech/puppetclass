class nginx::params {
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
  $default_documentRoot= $facts['os']['family'] ? {
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

}
