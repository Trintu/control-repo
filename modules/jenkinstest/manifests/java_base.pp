# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::java_base
class jenkinstest::java_base (
  String $version = 'puppet:///modules/jenkinstest/openjdk-11_linux-x64_bin.tar.gz'
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
