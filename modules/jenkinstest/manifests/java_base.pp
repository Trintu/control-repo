# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::java_base
class jenkinstest::java_base (
  String $jvmhome = lookup('jenkinstest::javahome.jvmhome'),
  String $verifylocation = lookup('jenkinstest::javaverify.location'),
  String $verifyfilename = lookup('jenkinstest::javaverify.filename'),
  String $verifyhome = lookup('jenkinstest::javahome.verifyhome'),
){
  file { "$jvmhome":
    ensure => directory,
    }
  file { "$verifyhome":
    ensure => directory,
    }
  exec { 'java-install':
      command     => '/usr/bin/sudo apt -y install openjdk-8-jre',
      refreshonly => true,
    }
  file { "$verifylocation": 
    source  => "$verifyfilename",
    ensure  => present,
    notify  => Exec['java-install'],
  }
}
