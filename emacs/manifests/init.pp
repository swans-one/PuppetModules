# = Class: emacs
#
# Install emacs and pull a configuration from github. Able to
# automatically handle the install location in the case of being used
# from vagrant.
#
# Downloads
#
# == Parameters:
#
# $user::        The github user who's emacs directory we're downloading
# $project::     The name of the project that contains the emacs configuration
# $owner::       Who's home directory do we put the configuration in?
# $group::       The group for the configuration files, defaults to user
# $packagename:: Defaults to 'emacs', can be set to something else
#
# == Requires:
#
# git::github-clone
#
# == Sample Usage:
#
#   class {'emacs':
#     user => 'Wilduck',
#     project => 'emacs-config',
#     packagename => 'emacs24-nox',
#   }
#
#   class {'emacs':
#     user => 'Wilduck',
#     project => 'emacs-config',
#     $owner => 'erik',
#   }
#
class emacs ($user, $project, $owner = 'root', $group = undef, $packagename = "emacs") {
  case $id {
    vagrant: {
      $emacsowner = 'vagrant'
      $emacsgroup = 'vagrant'
      $homedir = '/home/vagrant'
    }
    default: {  
      $emacsowner = $owner
      $emacsgroup = $group ? {undef => $owner, default => $group }
      $homedir = $owner ? {root => "/root", default => "/home/${owner}", }
    }
  }
  git::github-clone {"emacs-config-${emacsowner}":
    project   => $project,
    user      => $user,
    directory => $homedir,
    name      => ".emacs.d",
    owner     => $emacsowner,
    group     => $emacsgroup,
  }
  package {"emacs":
    name   => $packagename,
    ensure => latest,
  }
  exec {'change-.emacs.d-ownership':
    path => ['/bin','/sbin','/usr/bin','/usr/sbin'],
    cwd => $homedir,
    command => "chown -R ${emacsowner} .emacs.d",
  }

  Git::Github-Clone["emacs-config-${emacsowner}"] -> Exec['change-.emacs.d-ownership']
}
