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
  $owner = "root",
  $group = "root",
  ) {

  file {"${user}-${project}-${directory}":
    path => $directory,
    ensure => directory,
    owner => $owner,
  }

  notify {"git clone https://github.com/${user}/${project}": }
  
  exec {"clone-${user}-${project}":
    cwd => $directory,
    path => ['/usr/bin', '/usr/local/bin'],
    creates => "${directory}/${project}/.git",
    command => "git clone https://github.com/${user}/${project}",
  }
}
