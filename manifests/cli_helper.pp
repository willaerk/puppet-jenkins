# Class jenkins::cli_helper
#
# A helper script for creating resources via the Jenkins cli
#
class jenkins::cli_helper {

  include ::jenkins
  include ::jenkins::cli

  $libdir = $::jenkins::libdir
  $helper_groovy = "${libdir}/puppet_helper.groovy"

  file {$helper_groovy:
    source  => 'puppet:///modules/jenkins/puppet_helper.groovy',
    owner   => 'jenkins',
    group   => 'jenkins',
    mode    => '0444',
    require => Class['jenkins::cli'],
  }

  $helper_cmd = join([
    $::jenkins::cli::cmd,
    "groovy ${helper_groovy}",
    ],
    ' '
  )
}
