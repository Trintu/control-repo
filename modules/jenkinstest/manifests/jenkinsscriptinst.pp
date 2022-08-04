# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::jenkinsscriptinst

class jenkinstest::jenkinsscriptinst {
  class { 'jenkinstest::java_base':
    version => '8',
  }
  file { '/apps/': 
    ensure => directory,
  }
  file { '/apps/JenkinsInstaller.sh':
  ensure => file,
  source => "puppet:///modules/jenkinstest/jenkinsInstaller.sh"
  }
  exec { '/apps/JenkinsInstaller.sh':
    onlyif  => '/usr/bin/dpkg-query -W -f=\'\$\{Status\} jenkins |grep deinstall',
  }
}
