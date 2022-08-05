# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkinstest::environment_base
class jenkinstest::environment_base (
  String $homelocation = lookup('jenkinstest::javahome.location'),
  String $homefile     = lookup('jenkinstest::javahome.filename'),
){
#Putting down a .verify file here that confirms the install 
#completed successfully because it's the only trigger
#file I could find since when Jenkins uninstalls it doesn't
#remove /etc or /var files
  file { "$homelocation":
    ensure   => present,
    source   => "$homefile",
   }
   file { "/apps":
    ensure  => directory,
   }
}
