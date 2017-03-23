define user::managed_user (
  $user = $title,
  $home = "/home/${title}",
  $group = $title,
  $ssh = "/home/${title}/.ssh",
)
