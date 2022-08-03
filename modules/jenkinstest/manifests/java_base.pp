# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::java_base
class jenkinstest::java_base (
  String $version
){
  class{ 'java':
    version      => $version,
    distribution => 'jre',
  }
}
