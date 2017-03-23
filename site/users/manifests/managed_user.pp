define users::managed_user (
  $group = $title,
) {
  user { $title:
    ensure => present,
    gid => $group,
    home => "/home/${title}",
    managehome => true,
  }
  file { "/home/${title}":
    ensure => directory,
    owner => $title,
    group => $group,
  }
}
