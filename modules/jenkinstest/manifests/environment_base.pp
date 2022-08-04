# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::environment_base
class jenkinstest::environment_base (
  String $verifyfile = lookup('jenkinstest::verify.filename'),
  String $verifylocation = lookup('jenkinstest::verify.location'),
  String $homelocation = lookup('jenkinstest::javahome.location'),
  String $homefile = lookup('jenkinstest::javahome.filename'),
){
  file { "$homelocation":
    ensure   => present,
    source   => "$homefile",
   }
   file { "/apps":
    ensure  => directory,
   }
}
