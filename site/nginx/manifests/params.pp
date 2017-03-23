class nginx::params {
  $root = $$::osfamily ? {
    'windows' => 'C:/whateveritis'
    default => '/var/www',
  }
}
