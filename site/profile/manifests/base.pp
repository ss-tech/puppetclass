class profile::base {
  $message = hiera('message', "Where's my message on ${::hostname}")
  notify { $message: }
}
