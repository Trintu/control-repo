# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::java_base
class jenkinstest::java_base {
  file { '/tmp/java':
    ensure  => directory,
  }
  file { 'java-download':
    ensure           => present,
    path             => '/tmp/java/java',
    source           => "puppet:///modules/jenkinstest/openjdk-11_linux-x64_bin.tar.gz",
  }
#  class{ 'java':
#    version      => $version,
#    distribution => 'jre',
}
