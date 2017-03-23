class profile::base {
  $message = heira('message', "Where's my message on ${::hostname}")
  notify { $message: }
}
