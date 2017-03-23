class users::admins {
  users::managed_user { 'drew': }
  users::managed_user { ['enrique', 'padmashree']:
    group => 'staff',
  }
  group { 'staff':
    ensure => present,
  }
}
