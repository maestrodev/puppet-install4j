class install4j($version = '4.2.8', $license, $run_as, $homedir = 'UNSET', $download_url = 'UNSET') {

  File {
    owner => $run_as,
  }

  if $download_url == 'UNSET' {
    $underscore_version = regsubst($version, '\.', '_', 'G')
    $download_url_real = "http://download.ej-technologies.com/install4j/install4j_linux_${underscore_version}.rpm"
  }
  else {
    $download_url_real = $download_url
  }
  package { install4j:
    ensure => $version,
    source => $download_url_real,
    provider => rpm,
  }

  if $homedir == 'UNSET' {
    $actual_homedir = "/home/${run_as}"
  }
  else {
    $actual_homedir = $homedir
  }

  $majorVersion = regsubst($version, '^([0-9]+)\.([0-9]+)\.([0-9]+).*$', '\1')

  file { "$actual_homedir/.install4j":
    mode    => "0600",
    require => User[$run_as],
  }
  file { "$actual_homedir/.install4j$majorVersion":
    mode    => "0700",
    ensure  => directory,
    recurse => true,
    require => User[$run_as],
  }
  file { "$actual_homedir/.install4j$majorVersion/config.xml":
    mode    => "600",
    content => template("install4j/config.xml.erb"),
  }
}
