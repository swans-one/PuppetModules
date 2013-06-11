# = Class: update-repos::debian
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
#   class{'update-repos::debian': }
#
class update-repos::debian {
  $release = $lsbdistcodename
  file {'debian-sources-list-non-free':
    ensure => file,
    path => '/etc/apt/sources.list',
    source => "puppet:///modules/update-repos/debian-sources.list",
  }
  exec {'apt-get-update':
    path => ['/usr/bin/'],
    command => 'apt-get update',
    require => File['sources-list-non-free'],
  }
  if $release != 'raring' {
    notify{'wrongrelease':
      message => "Warn: sources.list just modified for release 'raring', not '${release}'",
    }
  }
}
