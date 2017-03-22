class users {
  user{ "fundamentals":
    ensure => 'present',
  }
  user{ "frankthetank":
    ensure     => 'present',
    name       => 'frank',
    password   => '!Q2w3e4r',
    managehome => true,
    
}

