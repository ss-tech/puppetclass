class users::admins {
  users::managed_user { 'jose': }
  users::managed_user { ['alice','chen']: 
      usergroup => 'staff',
  }
  
  group { [$title, 'staff']:
      ensure => present,
  }
}
