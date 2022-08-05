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
  file { "$verifylocation": 
    audit   => 'content',
    source  => "$verifyfilename",
    ensure  => present,
    notify  => [
      Exec['get-jenkins-key'],
      Exec['get-sources-list'],
      Exec['apt-update'],
      Exec['jenkins-install'],
    ]
    }
  exec { 'check install status':
    command     => "/usr/bin/dpkg-query -W -f=\\\$\{Status\} jenkins |grep install > $verifylocation"
  }
  file_line { 'port-change':
    ensure    => present,
    path      => '/etc/default/jenkins',
    line      => 'HTTP_PORT=8000',
    match     => '^HTTP_PORT\=',
  }
}
