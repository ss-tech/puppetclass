define users::managed_user (
 
)
{
  user { $title:
    ensure      => present,
    managehome => true,
    home        => "/home/${title}",  
    gid       => "staff",
}
