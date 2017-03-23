class users::admins {
  users:managed_user { 'joe': }
  users:managed_user { ['alice', 'aaron']:
    group => 'staff',
    }
  group { 'staff':
    ensure => 'present',
    }
    }
