class nginx (
  $index_file = $nginx::params::index_file,
  $conf_file = $nginx::params::conf_file,
  $default_file = $nginx::params::default_file,
  $package_name = $nginx::params::package_name,
  $owner = $nginx::params::owner,
  $group = $nginx::params::group,
  #$www_dir = $nginx::params::www_dir,
  $www_dir,
  $conf_root_dir = $nginx::params::conf_root_dir,
  $conf_incl_dir = $nginx::params::conf_incl_dir,
  $log_dir = $nginx::params::log_dir,
  $service = $nginx::params::service,
  $service_account = $nginx::params::service_account,
  $port = $nginx::params::port
) inherits nginx::params  {

  File {
    owner => 'root',
    group => 'root',
    mode => '0664'
  }

  package { "${package_name}":
    ensure => latest,
  }
  file { [ "${www_dir}", "${conf_root_dir}", "${conf_incl_dir}" ]:
    ensure => directory,
  }
  file { "${www_dir}/${index_file}":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
    #content =>  epp('nginx/index.html'),
  }
  file { "${conf_root_dir}/${conf_file}":
    ensure  => file,
    #source  => 'puppet:///modules/nginx/nginx.conf',
    content =>  epp('nginx/nginx.conf.epp',
    {
      package_name => $package_name,
      owner => $owner,
      group => $group,
      www_dir => $www_dir,
      conf_root_dir => $conf_root_dir,
      conf_incl_dir => $conf_incl_dir,
      log_dir => $nlog_dir,
      service => $service,
      service_account => $service_account,
      port => $port
    }),
    require => Package["${service}"],
    notify  => Service["${service}"],
  }

  file { "${conf_incl_dir}/${default_file}":
    ensure  => file,
    #source  => 'puppet:///modules/nginx/default.conf',
    content =>  epp('nginx/default.conf.epp',
    {
      package_name => $package_name,
      owner => $owner,
      group => $group,
      www_dir => $www_dir,
      conf_root_dir => $conf_root_dir,
      conf_incl_dir => $conf_incl_dir,
      log_dir => $nlog_dir,
      service => $service,
      service_account => $service_account,
      port => $port
    }),
    require => Package["${service}"],
    notify  => Service["${service}"],
  }
  service { "${service}":
    ensure => running,
    enable => true,
  }
}
