define users::managed_user (
  $group = $title,
  $sshdir = "$homedir/.ssh",
) {
  user { $title:
    ensure => present,
    home => "/home/${title}",
    managehome => true,
  }
  file { "/home/${title}/.ssh":
    ensure => directory,
  }
}
