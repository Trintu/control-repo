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
){
    exec { 'get-jenkins-key':
      command     => "/usr/bin/wget -qq -O - $keyurl | sudo apt-key add -",
      refreshonly => true,
    }
  exec { 'get-sources-list':
    command  => "/usr/bin/sudo sh -c \'echo deb $sourceurl binary/ > /etc/apt/sources.list.d/jenkins.list\'",
    refreshonly => true,
  }
  exec { 'apt-update':
    command  => '/usr/bin/sudo apt update',
    refreshonly => true,
  } 
  exec { 'jenkins-install':
    command  => '/usr/bin/sudo apt-get -q -y install jenkins',
    refreshonly => true,
  }
  exec { 'jenkins-daemon':
    command  => '/usr/bin/sudo systemctl daemon-reload',
    refreshonly => true,
  }  
  exec { 'jenkins-restart':
    command  => '/usr/bin/sudo systemctl restart jenkins',
    refreshonly => true,
  } 
  file { "$verifylocation": 
    audit          => 'content',
    source         => "$verifyfilename",
    checksum       => 'md5',
    checksum_value => '6125189d0eb30a71c851664287235515',
    ensure         => present,
    notify         => [
      Exec['get-jenkins-key'],
      Exec['get-sources-list'],
      Exec['apt-update'],
      Exec['jenkins-install'],
    ]
    }
  exec { 'check install status':
    command     => "/usr/bin/dpkg-query -W -f=\\\$\{Status\} jenkins |grep install > $verifylocation"
  }
  file_line { 'config-port-change':
    ensure    => present,
    path      => '/etc/default/jenkins',
    line      => 'HTTP_PORT=8000',
    match     => '^HTTP_PORT\=',
  }
  file_line { 'service-port-change':
    ensure    => present,
    path      => '/lib/systemd/system/jenkins.service',
    line      => 'Environment="JENKINS_PORT=8000"',
    match     => '^Environment="JENKINS_PORT=',
    notify  => [
      Exec['jenkins-daemon'],
      Exec['jenkins-restart'],
    ]
  }
}
