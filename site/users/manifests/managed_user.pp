#    Manage the resources for:
#        The user.
#        The user's home directory.
#        The user's group, .ssh directory, or any other useful resources.

define users::managed_user (
  $group = $title
) {
  user { $title:
  ensure  => present,
  home    => "/home/${user}",
  
  
