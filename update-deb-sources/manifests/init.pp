#
# This module
#
class update-deb-sources {
  file {'sources-list-non-free':
    ensure => file,
    path => '/etc/apt/sources.list',
    source => "puppet:///modules/update-deb-sources/sources.list",
  }
  exec {'apt-get-update':
    path => ['/usr/bin/'],
    command => 'apt-get update',
    require => File['sources-list-non-free'],
  }
}
