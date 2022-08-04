# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::java_base
class jenkinstest::java_base (
  String $jvmhome => lookup('jenkinstest::java.jvmhome'),
    {
  file { '$jvmhome':
    ensure => directory,
    }
  exec { 'java-install':
      command     => '/usr/bin/sudo apt -y install openjdk-8-jre',
      refreshonly => true,
    }
  exec { "chk_/usr/lib/jvm/java-8-openjdk-amd64/jre/bin_exist":
    command => "true",
    path    => ["/usr/bin","/usr/sbin","/bin"],
    notify  => Exec['java-install'],
  }
}
