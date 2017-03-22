file { [ 'foo', 'bar' ]:
  ensure  => directory,
  path    => [ '/etc/foo', '/etc/bar' ],
}

