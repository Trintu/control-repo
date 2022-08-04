# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::environment_base
class jenkinstest::environment_base {
  file { "/etc/profile.d/set_java_home.sh":
    ensure   => present,
    source   => "puppet:///modules/jenkinstest/set_java_home.sh"
   }
   file { "/apps":
    ensure  => directory,
    }
}
