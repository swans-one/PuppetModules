# = Class: vagrant-nginx
#
# Install nginx, setup some configuration, ensure that it's running.
#
# Basic Package/File/Service
#
# == Parameters:
#
# == Requires:
#
# == Sample Usage:
#
#
class vagrant-nginx (
  $binarylocation = '/usr/sbin',
  $configlocation = '/etc/nginx/nginx.conf',
  ) {

  package {'nginx':
    ensure => present,
    before => File['vagrant-nginx-config'],
  }
  file {'vagrant-nginx-config':
    path => $configlocation,
    source => "puppet:///modules/vagrant-nginx/nginx-gunicorn.conf",
  }
  exec {'nginx':
    path => ['/usr/sbin/', $binarylocation],
    command => "nginx -c ${configlocation}",
    require => File['vagrant-nginx-config'],
  }
}
