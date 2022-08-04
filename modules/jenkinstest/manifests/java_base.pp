# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::java_base
class jenkinstest::java_base (
  String $jvmhome = lookup('jenkinstest::java.jvmhome'),
  String $javasource = lookup('jenkinstest::java.javasource'),
  String $javaverify = lookup('jenkinstest::java.javaverify'),
){
  file { "$jvmhome":
    ensure => directory,
    }
  exec { 'java-install':
      command     => '/usr/bin/sudo apt -y install openjdk-8-jre',
      refreshonly => true,
    }
  file { "$javaverify": 
    audit   => 'content',
    source  => "$javasource",
    ensure  => present,
    notify  => Exec['java-install'],
  }
}
