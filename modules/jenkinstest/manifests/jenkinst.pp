# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::jenkinst

class jenkinstest::jenkinst (
  String $keyurl = lookup('jenkinstest::jenkinsurls.keyurl'),
  String $sourceurl = lookup('jenkinstest::jenkinsurls.sourceurl'),
  String $dpkgoutfile = lookup('jenkinstest::queryfile.dpkg'),
  String $filename = lookup('jenkinstest::verify.filename'),
  String $location = lookup('jenkinstest::verify.location'),
){
  exec { 'get-jenkins-key':
    command     => "/usr/bin/wget -qq -O - $keyurl | sudo apt-key add -",
    refreshonly => true,
  } ->
  exec { 'get-sources-list':
    command  => '/usr/bin/sudo sh -c \'echo deb $sourceurl binary/ > /etc/apt/sources.list.d/jenkins.list\'',
    refreshonly => true,
  } ->
  exec { 'apt-update':
    command  => '/usr/bin/sudo apt update',
    refreshonly => true,
  } ->
  exec { 'jenkins-install':
    command  => '/usr/bin/sudo apt-get -qq install jenkins',
    refreshonly => true,
  } ->
  exec { 'jenkins-start':
   command  => '/usr/bin/sudo systemctl start jenkins',
   refreshonly => true,
  }
  file { "$location": 
    audit   => 'content',
    source  => "$filename",
    ensure  => present,
    notify  => Exec['get-jenkins-key']
    }
  exec { 'check install status':
    command     => "/usr/bin/dpkg-query -W -f=\\\\\$\{Status\} jenkins |grep install > $dpkgoutfile"
  }
}
