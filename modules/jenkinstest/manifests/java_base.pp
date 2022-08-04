# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::java_base
class jenkinstest::java_base (
  String $verifyfilename = lookup('jenkinstest::javaverify.filename'),
  String $verifylocation = lookup('jenkinstest::javaverify.location'),
){
  file { [ '/usr/lib/jvm', '/usr/lib/jvm/java-8-openjdk-amd64',
           '/usr/lib/jvm/java-8-openjdk-amd64/docs' ]:
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
