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
  user { "thedarkwriter":
    ensure     => 'present',
    managehome => true,
    password   => '!Q2w3e4r',
}

