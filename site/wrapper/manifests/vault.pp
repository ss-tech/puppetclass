class wrapper::vault {
 class { '::vault':
  user => 'vault',
  group => 'vault',
 }
}
