# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::jenkinst
class jenkinstest::jenkinst {
  exec { 'get-jenkins-key':
    command  => '/usr/bin/wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -',
  }
  exec { 'get-sources-list':
    command  => '/usr/bin/sudo sh -c \'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list\'',
  }
  exec { 'apt-update':
    command  => '/usr/bin/sudo apt update',
  }
  exec { 'jenkins-install':
    command  => '/usr/bin/sudo apt -qq install jenkins',
  }
  exec { 'jenkins-start':
    command  => '/usr/bin/sudo systemctl start jenkins',
  }
  exec { 'jenkins-status':
    command  => '/usr/bin/sudo systemctl status jenkins > /opt/status.txt',
  }
}
