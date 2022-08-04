# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::java_base
class jenkinstest::java_base (
  String $version
){
  file { '/tmp/java':
    ensure  => directory,
  }
  file { '':
    ensure           => present,
    path             => '/tmp/java/',
    source           => 'https://download.java.net/java/ga/jdk11/openjdk-11_linux-x64_bin.tar.gz',
  }
#  class{ 'java':
#    version      => $version,
#    distribution => 'jre',
}
