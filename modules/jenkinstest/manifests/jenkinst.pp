# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::jenkinst

class jenkinstest::jenkinst {
  class { 'jenkinstest::java_base':
    version => '8',
  }
  exec { 'get-jenkins-key':
    command     => '/usr/bin/wget -qq -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -',
    refreshonly => true,
  }
  exec { 'get-sources-list':
    command  => '/usr/bin/sudo sh -c \'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list\'',
    refreshonly => true,
  }
  exec { 'apt-update':
    command  => '/usr/bin/sudo apt update',
    refreshonly => true,
  }
  exec { 'jenkins-install':
    command  => '/usr/bin/sudo apt-get -qq install jenkins',
    refreshonly => true,
  }
  exec { 'jenkins-start':
   command  => '/usr/bin/sudo systemctl start jenkins',
  }
  exec { 'jenkins-status':
    command  => '/usr/bin/sudo systemctl status jenkins > /opt/status.txt',
  }
}
