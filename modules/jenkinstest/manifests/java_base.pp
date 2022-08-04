# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::java_base
class jenkinstest::java_base (
  String $version = jenkinstest::javaurl.url
){
  file { '/tmp/java':
    ensure  => directory,
  }
  file { 'java-download':
    ensure           => present,
    path             => '/tmp/java/',
    source           => "$version",
  }
#  class{ 'java':
#    version      => $version,
#    distribution => 'jre',
}
