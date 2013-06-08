#
# Definition: julia-from-source
#
# This class builds and installs Julia from Source using the official
# github repository.
#
# Actions:
# - Checks for and installs dependencies
# - Clones from the official github repository
# - Makes and installs Julia
#
# Requires:
# - the `git` class
# - the `git::github-clone` type
#
# Sample Usage:
#   include julia-from-source
#
class julia-from-source {
  # The directory to build Julia in.
  class {'install-dependencies': }
  class {'download-julia': }
  class {'build-julia': }

  Class['install-dependencies'] -> Class['download-julia']
  Class['download-julia']       -> Class['build-julia']
}

class install-dependencies {
  # Since we have a module for this one:
  include git
  notify {'git_anchor_first':} -> Class['git'] -> notify {'git_anchor_last':}
  # The dependencies, as listed on Julia's github page (less git).
  package {'build-essential':
    ensure => latest,
  }
  package {'gcc':
    ensure => latest,
  }
  package {'gcc-doc':
    ensure => latest,
  }
  package {'clang':
    ensure => latest,
  }
  package {'gfortran':
    ensure => latest,
  }
  package {'wget':
    ensure => latest,
  }
  package {'curl':
    ensure => latest,
  }
  package {'m4':
    ensure => latest,
  }
  package {'patch':
    ensure => latest,
  }
  # This is not listed as a dependency, but apparently it is.
  package {'libncurses5-dev':
    ensure => latest,
  }
}

class download-julia {
  git::github-clone {'julia':
    user      => 'JuliaLang',
    directory => '/opt',
  }

  file {'/opt/julia':
    ensure  => directory,
    owner   => "vagrant",
    group   => "vagrant",
    recurse => true,
  }
}

class build-julia {
  exec {'make':
    path    => ['/bin',
                '/sbin',
                '/usr/bin',
                '/usr/sbin',
                '/usr/local/sbin',
                '/usr/local/bin'],
    cwd     => '/opt/julia',
    timeout => 0,
  }
  exec {'make install':
    path    => ['/bin',
                '/sbin',
                '/usr/bin',
                '/usr/sbin',
                '/usr/local/sbin',
                '/usr/local/bin'],
    cwd     => '/opt/julia',
    timeout => 0,
  }
  Exec['make'] -> Exec['make install']
}
