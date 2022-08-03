class profile::base {

  #the base profile should include component modules that will be on all nodes
  class { 'java':
  distribution => 'jdk',
  version      => '8',
}
}
