class users::admins {
  users::managed_user { 'jose': 
      require => Group["jose"],
  }
  #users::managed_user { ['alice','chen']: 
  #    usergroup => 'staff',
  #    require => Group["staff"],
  #}
  
  #group { 'staff':
  #    ensure => present,
  #}
  group { "jose":
      ensure => present,
  }
}
