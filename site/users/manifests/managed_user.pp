define user::managed_user (
  $user = $title,
  $home = "/home/${title}",
  $group = $title,
  $ssh = "/home/${title}/.ssh",
) {
  user { $title:
    ensure => present,
    home => $home,
    managehome => true,
  }
  file { $ssh:
    ensure => directory,
    mode => '0700',
    owner => $user,
    group => $group,
  }
}
