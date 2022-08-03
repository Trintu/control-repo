# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::java_base
class jenkinstest::java_base {
  class{ 'java':
    version      => '8',
    distribution => 'jre',
  }
}
