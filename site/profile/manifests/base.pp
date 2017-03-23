class profile::base {
  notify { "Hello, my name is ${::hostname}": }
  # /etc/puppetlabs/code/environments/production/hieradata/common.yaml
  message: "This is a sample variable that came from Hiera"
}
