define users::managed_users {
  $group = $title,
  }
  {
    user {$title:
        enusre => present,
        home => "/home/${title}",
        managehome => true,
        
  }
