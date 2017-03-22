class nginx {

  $nginxserviceaccount = $facts['os']['name'] ? {
    'ubuntu' => 'nginx',
    'redhat' => 'nginx'
    'windows' => 'noboxy'
    default  => 'nginx',
  }

  $nginx_www_dir = '/var/www'
  $nginx_conf_root_dir = '/etc/nginx'
  $nginx_conf_incl_dir = '/etc/nginx/conf.d'
  $nginx_index_file = 'index.html'
  $nginx_conf_file = 'nginx.conf'
  $nginx_default_file = 'default.conf'

  File {
    owner => 'root',
    group => 'root',
    mode => '0664'
  }


  package { 'nginx':
    ensure => present,
  }
  file { [ $nginx_www_dir, $nginx_conf_root_dir, $nginx_conf_incl_dir ]:
    ensure => directory,
  }
  file { "${nginx_www_dir}/${nginx_index_file}":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  file { "${nginx_conf_root_dir}/${nginx_conf_file}":
    ensure  => file,
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  file { "${nginx_conf_incl_dir}/${nginx_default_file}":
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
