class profile::base {
  $message = hiera('message')
  notify { "Hello, my name is ${::hostname}": }
  notify { "This is a hiera message: ${message}": }
}
