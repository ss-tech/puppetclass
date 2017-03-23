class vault::vault_wrap {
 class { '::vault':
  user => 'vault',
  group => 'vault',
 }
}
