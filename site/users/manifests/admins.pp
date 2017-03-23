class users::admins {
 users::managed_users{'allen':}
 users::managed_users{['lolcat','unicorn']:
    group => 'staff',
    }
  group {'staff:
   ensure => present,
   }
 }
