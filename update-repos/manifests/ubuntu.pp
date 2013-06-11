# = Class: update-repos::ubuntu
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
#   class{'update-repos::ubuntu': }
#
class update-repos::ubuntu {
  $release = $lsbdistcodename
  file {'ubuntu-sources-list':
    ensure => file,
    path => '/etc/apt/sources.list',
    source => "puppet:///modules/update-repos/ubuntu-sources.list",
  }
  exec {'apt-get-update':
    path => ['/usr/bin/'],
    command => 'apt-get update',
    require => File['ubuntu-sources-list'],
  }
  if $release != 'raring' {
    notify{'wrongrelease':
      message => "Warn: sources.list just modified for release 'raring', not '${release}'",
    }
  }
}
