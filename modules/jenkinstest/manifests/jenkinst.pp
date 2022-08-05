# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::jenkinst

class jenkinstest::jenkinst (
  String $keyurl = lookup('jenkinstest::jenkinsurls.keyurl'),
  String $sourceurl = lookup('jenkinstest::jenkinsurls.sourceurl'),
  String $verifyfilename = lookup('jenkinstest::jenkinsverify.filename'),
  String $verifylocation = lookup('jenkinstest::jenkinsverify.location'),
  String $checksum = lookup('jenkinstest::jenkinsverify.checksum'),
  String $jenkinsport = lookup('jenkinstest::jenkinsverify.jenkinsport'),
){
#get jenkins key here
    exec { 'get-jenkins-key':
      command     => "/usr/bin/wget -qq -O - $keyurl | sudo apt-key add -",
      refreshonly => true,
    }
#adding jenkins sources
  exec { 'get-sources-list':
    command  => "/usr/bin/sudo sh -c \'echo deb $sourceurl binary/ > /etc/apt/sources.list.d/jenkins.list\'",
    refreshonly => true,
  }
#updating after getting the sources
  exec { 'apt-update':
    command  => '/usr/bin/sudo apt update',
    refreshonly => true,
  } 
#installing Jenkins
  exec { 'jenkins-install':
    command  => '/usr/bin/sudo apt-get -q -y install jenkins',
    refreshonly => true,
  }
#we make a port change below to the system file, so if the
#jenkins service port isn't 8000 this will trigger
  exec { 'jenkins-daemon':
    command  => '/usr/bin/sudo systemctl daemon-reload',
    refreshonly => true,
  }  
#this is the restart that's called after the daemon reload.
  exec { 'jenkins-restart':
    command  => '/usr/bin/sudo systemctl restart jenkins',
    refreshonly => true,
  } 
#this searches for the .verify file I'm dropping to confirm
#the installation was done correctly. The file will be updated
#with deinstall if Jenkins is uninstalled, which will then
#trigger a re-install of the application.
  file { "$verifylocation": 
    audit          => 'content',
    source         => "$verifyfilename",
    checksum       => 'md5',
    checksum_value => "$checksum",
    ensure         => present,
    notify         => [
      Exec['get-jenkins-key'],
      Exec['get-sources-list'],
      Exec['apt-update'],
      Exec['jenkins-install'],
    ]
    }
#this queries dpkg to find the jenkins install status, it will
#either return installed and won't do anything, or if it returns
#anything else it will trigger a re-install of the app.
  exec { 'check install status':
    command     => "/usr/bin/dpkg-query -W -f=\\\$\{Status\} jenkins |grep install > $verifylocation"
  }
#port change on what I thought was the working config file...
#but even though it didn't change the service port, I wanted
#to ensure it was still set to 8000
  file_line { 'config-port-change':
    ensure    => present,
    path      => '/etc/default/jenkins',
    line      => "HTTP_PORT=$jenkinsport",
    match     => '^HTTP_PORT\=',
  }
#port change that actually mattered to the service, if it gets
#changed to anyting except 8000 it will trigger the update,
#reload the daemon, and restart the service.
  file_line { 'service-port-change':
    ensure    => present,
    path      => '/lib/systemd/system/jenkins.service',
    line      => "Environment=\"JENKINS_PORT=$jenkinsport\"",
    match     => '^Environment="JENKINS_PORT=',
    notify  => [
      Exec['jenkins-daemon'],
      Exec['jenkins-restart'],
    ]
  }
}
