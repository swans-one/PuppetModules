#
# = Definition: git::github-clone
#
# This class clones a project from github.
#
# == Parameters:
#
# - The $user who's project to clone (github username)
# - The $project to clone
# - The $directory to clone it into
# - The $name of the directory to put the project within ${directory}
# - The $owner of the project directory
# - The $group of the project directory
#
# == Actions:
#
# - Creates a git repository that is a clone of the specified
#   project
#
# == Requires:
#
# - The git class
#
# == Sample Usage:
#
#   git::github-clone {'julia':
#     user      => 'JuliaLang',
#     directory => '/opt',
#     owner     => 'vagrant',
#     group     => 'vagrant',
#   }
define git::github-clone(
  $user,
  $project = $title,
  $directory = '/opt',
  $name = '',
  $owner = "root",
  $group = "root",
  ) {

  include git
  Class['git'] -> Exec["clone-${user}-${project}"]
  
  file {"${user}-${project}-${directory}":
    path => $directory,
    ensure => directory,
    owner => $owner,
  }

  file {"${directory}/${name}":
    ensure => absent,
  }
  
  exec {"clone-${user}-${project}":
    cwd => $directory,
    path => ['/usr/bin', '/usr/local/bin'],
    creates => "${directory}/${project}/.git",
    command => "git clone https://github.com/${user}/${project}.git ${name}",
  }

  File["${user}-${project}-${directory}"] -> File["${directory}/${name}"]
  File["${directory}/${name}"] -> Exec["clone-${user}-${project}"]
}
