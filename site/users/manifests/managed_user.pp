define users::managed_user (
 
)
{
  user { ${title}:
    ensure      => present,
    managedhome => true,
    home        => "/home/${title}",  
    group       => "staff",
}
