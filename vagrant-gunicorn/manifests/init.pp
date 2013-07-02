# = Class: vagrant-gunicorn
#
# Install gunicorn, and configure it to work on a vagrant virtual
# machine.
#
# Also installs libevent/gevent for workers and Flask for a
# webframework.
#
# == Parameters:
#
# == Requires:
#
# == Sample Usage:
#
#
class vagrant-gunicorn {

  # Install all the necessary packages
  package {'python2.7':
    ensure => present,
    before => Notify['before-deps'];
  }
  package {'python-pip':
    ensure => present,
    before => Notify['before-deps'];
  }
  package {'python2.7-dev':
    ensure => present,
    before => Notify['before-deps'];
  }
  package {'gunicorn':
    ensure => present,
    before => Notify['before-deps'];
  }
  package {'libevent-dev':
    ensure => present,
    before => Notify['before-deps'];
  }
  notify {'before-deps':
    message => 'vagrant-gunicorn--First set of packages installed'
  }
  package {'gevent':
    ensure => present,
    provider => pip,
    require => Notify['before-deps'],
    before => Notify['packages-done'],
  }
  package {'Flask':
    ensure => present,
    provider => pip,
    require => Notify['before-deps'],
    before => Notify['packages-done'],
  }

  notify {'packages-done':
    message => 'vagrant-gunicorn--All packages installed',
  }
}
