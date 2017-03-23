class users::admins {
  users::managed_user{ 'chad': }
  users::managed_user{ 'drew':
    group => 'developer',
  }
  
  group { 'developer':
    ensure => present,
   }
}
