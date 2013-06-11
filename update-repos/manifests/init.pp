# = Class: update-repos
#
# This class determines the linux distribution being used, and then
# executes the proper steps to manage the sources of the repositores
# and updates the package list.
#
# == Parameters:
#
# $distro:: Optional. Overrides facter's choice of distribution. While
#           this will not make it possible to use distributions that
#           are not supported it will allow specification where facter
#           is incorect.
#
# == Requires:
#
# Nothing
#
# == Sample Usage:
#
#   class{'update-repos': }
#
#   class{'update-repos':
#     distro => "ubuntu",
#   }
#
class update-repos ($distro = undef) {
  if $distro == undef {
    # On linux systems, `$operatingsystem` returns the flavor
    $distrobution = $operatingsystem
  }
  else {
    $distrobution = $distro
  }
  case $distrobution {
    debian: {
      class {'update-repos::debian': }
    }
    ubuntu: {
      class {'update-repos::ubuntu': }
    }
    default: {
      fail("Error: No update routine for the operating system/distribution ${distro}")
    }
  }
}

