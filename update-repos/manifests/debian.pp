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
  file {'debian-sources-list':
    ensure => file,
    path => '/etc/apt/sources.list',
    source => "puppet:///modules/update-repos/debian-sources.list",
  }
  exec {'apt-get-update':
    path => ['/usr/bin/'],
    command => 'apt-get update',
    require => File['debian-sources-list'],
  }
  if $release != 'wheezy' {
    notify{'wrongrelease':
      message => "Warn: sources.list just modified for release 'wheezy', not '${release}'",
    }
  }
}
