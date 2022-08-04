# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::environment_base
class jenkinstest::environment_base {
  file { "/etc/environment.test":
      content => inline_template('/usr/lib/jvm/jdk-11/bin:/usr/lib/jvm/jdk-11/db/bin:/usr/lib/jvm/jdk-11/jre/bin')
   }
}
