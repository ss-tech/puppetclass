class profile::base {
  #notify { "$message": }
  $message = hiera('message')
  notify { "$message": }
}
