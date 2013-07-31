define install4j::jre(
  $repo,
  $groupId = "com.oracle.java",
  $installpath = "UNSET"
) {
  if $installpath == "UNSET" {
    if $install4j::majorVersion == "5" {
      $installpath_real = "/opt/install4j5"
    } else {
      $installpath_real = "/opt/install4j"
    }
  }
  else {
    $installpath_real = $installpath
  }

  $groupPath = regsubst($groupId, '\.', '/', 'G')
  $path = regsubst($name, '^(.*)-([0-9._]+)$', "$groupPath/\\1/\\2/\\1-\\2.tar.gz")
  wget::authfetch { "fetch-${name}_jre":
    source => "${repo['url']}/${path}",
    destination => "$installpath_real/jres/${name}.tar.gz",
    user => $repo['username'],
    password => $repo['password'],
  }
}

