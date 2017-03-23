class users::admins {
  users::managed_user { 'someadmin1':
    group => 'admins',
  }
  
  users::managed_user { 'someadmin2':
    group => 'admins',
  }
  
  users::managed_user { 'someadmin3':
    group => 'ltdadmin',
  }
  
  group { 'admins':
    ensure  => present,
  }
  group { 'ltdadmin':
    ensure  => present,
  }
}
