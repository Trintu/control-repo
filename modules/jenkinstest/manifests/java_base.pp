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
#Creating the java install's directories so that I can validate
#the java installer completed successfully, ensuring 
#the file JAVA_HOME is exists, so if it gets removed, it'll 
#trigger another install
  file { [ '/usr/lib/jvm', '/usr/lib/jvm/java-8-openjdk-amd64',
           '/usr/lib/jvm/java-8-openjdk-amd64/docs' ]:
    ensure => directory,
    }
#java install run
  exec { 'java-install':
      command     => '/usr/bin/sudo apt -y install openjdk-8-jre',
      refreshonly => true,
    }
#This is checking for the JAVA_HOME file, it will run the java
#install again if it can't find it.
  file { "$verifylocation": 
    source  => "$verifyfilename",
    ensure  => present,
    notify  => Exec['java-install'],
  }
}
