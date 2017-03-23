class profile::base {
  $message => hiera('message')
  notify { " This is a node specific ${message}": }
}
