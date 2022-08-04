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
  file { '/usr/lib/jvm':
    ensure => directory,
    }
  file { 'java-download':
    path             => '/tmp/java/openjdk-11_linux-x64_bin.tar.gz',
    source           => "puppet:///modules/jenkinstest/openjdk-11_linux-x64_bin.tar.gz",
  } ->
  exec { 'java-extract':
    command => '/usr/bin/tar -xf /tmp/java/openjdk-11_linux-x64_bin.tar.gz --directory /usr/lib/jvm',
    refreshonly => true,
  } ->
  exec { 'file cleanup':
    command   => '/usr/bin/rm /tmp/java/openjdk-11_linux-x64_bin.tar.gz',
    refreshonly => true,
  }
  file { '/usr/lib/jvm/jdk-11': 
    audit   => 'content',
    ensure  => present,
    notify  => Exec['java-download']
  }
#  class{ 'java':
#    version      => $version,
#    distribution => 'jre',
}
