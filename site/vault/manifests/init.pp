class vault {
 class { '::vault':
  user => 'vault',
  group => 'vault',
 }
}
