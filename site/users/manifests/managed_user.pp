define users::managed_user (
   group => $title
)
{
  user { $title:
    ensure      => present,
    managehome => true,
    home        => "/home/${title}",  
    gid       => $group,
}
  file { "/home/${title}/.ssh:
    ensure => directory,
    owner => $title,
    group => $title,
}
