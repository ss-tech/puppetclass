class users::admins {
  users::managed_user { 'bruce': }
  users::managed_user { 'shari': 
    group => 'wife'
  }
  
  group { 'wife':
    ensure => present,
  }
}
