define users::managed_user (
  $group = $title,
) {
  user { $title:
    ensure => present,
    gid => $group,
    home => "/home/${title}",
    managehome => true,
  }
  group { $group:
    ensure => present,
  }
}
