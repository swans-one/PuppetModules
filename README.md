
Puppet Modules for Vagrant
========================================

The following modules are simple. I'm using these modules to provision
my personal vagrant dev environments. For this reason I make no
guarantees that this will work on anyone else's machine. That being
said, all of the code in this repository is released under the
[WTFPL](http://www.wtfpl.net/).


The `git` module
----------------------------------------

This module has a class `git` which installs git. It also provides

### `git::github-clone`

This defined type can download a given package from a given github
user into a given directory. Basic usage:

    git::github-clone {'julia':
      user      => 'JuliaLang',
      directory => '/opt',
    }

### `git::config::global`

This class allows the user to set up the global configuration options
necessary to immediately begin committing to projects. Basic usage:

    class {'git::config::global':
      username  => "John Doe",
      useremail => "John.Doe@example.com",
    }

The `julia-from-source` module
----------------------------------------

This module provides a class that download the dependencies for the
Julia Statistical software package, clones the official github
repository, and runs `make` and `make install` to install it. 

This process takes a significant amount of time. It should not be
attempted without a fairly good web connection and decently fast
processor.

The `update-repos` module
----------------------------------------

This is a class that ensures that package managers are configured
correctly and package lists are up to date in a distrobution
independent way. Currently only supports Ubuntu 13.04 and Debian
7.0. Will fail with an error otherwise. Basic usage:

    class {'update-repos': }

For an Ubuntu box, this module updates the `sources.list` file to
include the universe repositories, as well as security updates
repositories. It then runs `apt-get update` to refresh the list of
packages available.

For a debian box, this module updates the `sources.list` file to include
`contrib` and `non-free` repository and then runs `apt-get update` to
refresh the list of packages available.

The `emacs` module
----------------------------------------

The emacs module makes sure that `emacs` is installed, and pulls an
emacs configuration repository from github. This module depends on the
`git` module, specifically `git::github-clone`.

This module requires that the github user and project containing the
`.emacs.d` directory be specified, as well as the user that will be
the owner on the local computer.  Basic usage:

    class {'emacs':
      user	=> "Wilduck",
      project	=> "emacs-config",
      owner	=> "erik",
    }

It also provides the ability to install a different version of emacs
(such as `emacs24-nox`) in the distrobution's package repository, by
specifiying the optional `packagename` parameter.
