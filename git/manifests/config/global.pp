#
# = Class: git::config::global
#
# This class controls global configuration options for git.
#
# == Parameters:
#
# $username::  The user's name that will be used when committing to git
#              repositories. This string should include both first and
#              last names
#
# $useremail:: The user's email that will be used when commiting to
#              git repositories.
#
# == Requires:
#
# git
#
# == Sample Usage"
#
#   class {'git::config::global':
#     username => "John Doe",
#     useremail => "john.h.doe@example.com",
#   }
#
class git::config::global (
  $username  = undef,
  $useremail = undef
  ) {

  include git

  if username == undef or useremail == undef {
    fail("username and useremail parameters required")
  }

  exec {'git-global-username':
    path    => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
    command => "git config --global user.name ${username}",
    require => Class['git'],
  }
  exec {'git-global-useremail':
    path    => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
    command => "git config --global user.email ${useremail}",
    require => Class['git'],
  }
}
