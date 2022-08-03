# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::jenkinst
class jenkinstest::jenkinst {
  file {'/tmp/hello':
    ensure   => 'present',
    content  => 'Hello World',
    path     => '/tmp/hello',
  }
}
