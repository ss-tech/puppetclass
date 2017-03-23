class wrappers::epel {
  class { '::epelp':
    epel_testing_enabled => '1',
    epel_source_enabled => '1',
  }
}
