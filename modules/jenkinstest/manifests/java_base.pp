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
    path             => '/tmp/java/openjdk-11_linux-x64_bin.tar.gz',
    source           => "puppet:///modules/jenkinstest/openjdk-11_linux-x64_bin.tar.gz",
  }
  file { '/usr/lib/jvm':
    ensure => directory,
    }

  exec { 'java-extract':
    command => '/usr/bin/tar -xf /tmp/java/openjdk-11_linux-x64_bin.tar.gz --directory /usr/lib/jvm'
  }

  exec { 'cleanup zip':
    command => 'rm /tmp/java/openjdk-11_linux-x64_bin.tar.gz'
  }
#  class{ 'java':
#    version      => $version,
#    distribution => 'jre',
}
