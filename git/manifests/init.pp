#
# = Class: git
#
# Installs git. Also provides the namespace for other git related
# actions. All classes/definitions under this namespace should include
# this class.
#
# == Parameters:
#
# None.
#
# == Requires:
#
# Nothing.
#
# == Sample Usage:
#
#   include git
#
class git {
  package {'git':
    ensure => present,
  }
}
