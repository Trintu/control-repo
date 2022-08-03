# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::jenkinst
class jenkinstest::jenkinst {
  exec { 'get-jenkins-key':
    cwd      => '/usr/bin',
    command  => 'wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -',
  }
  exec { 'get-sources-list':
    command  => 'sudo sh -c \'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list\'',
  }
  exec { 'apt-update':
    command  => 'sudo apt update',
  }
  exec { 'jenkins-install':
    command  => 'sudo apt install jenkins',
  }
  exec { 'jenkins-start':
    command  => 'sudo systemctl start jenkins',
  }
  exec { 'jenkins-status':
    command  => 'sudo systemctl status jenkins > /opt/status.txt',
  }
}
