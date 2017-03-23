define users::managed_user (
 
)
{
  user { $title:
    ensure      => present,
    managehome => true,
    home        => "/home/${title}",  
    gid       => "staff",
}
  file { "/home/${title}/.ssh:
    ensure => directory,
    owner => $title,
    group => $title,
}
