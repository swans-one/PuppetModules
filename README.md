
Puppet Modules for Vagrant
========================================

The `git` module
----------------------------------------

This module has a class `git` which installs git. It also provides

### `git::github-clone`

This defined type can download a given package from a given github
user into a given directory. Example usage:

    git::github-clone {'julia':
      user      => 'JuliaLang',
      directory => '/opt',
    }


The `julia-from-source` module
----------------------------------------

This module provides a class that download the dependencies for the
Julia Statistical software package, clones the official github
repository, and runs `make` and `make install` to install it. 

This process takes a significant amount of time.

The `update-deb-sources` module
----------------------------------------

This module updates the sources.list file for a debian box to include
`contrib` and `non-free` repository and then runs `apt-get update` to
refresh the list of packages available.