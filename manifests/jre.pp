define install4j::jre(
  $repo,
  $groupId = "com.oracle.java"
) {
  $groupPath = regsubst($groupId, '\.', '/', 'G')
  $path = regsubst($name, '^(.*)-([0-9._]+)$', "$groupPath/\1/\2/\1-\2.tar.gz")
  wget::authfetch { "fetch-${name}_jre":
    source => "${repo['url']}/${path}",
    destination => "/opt/install4j/jres/${name}.tar.gz",
    user => $repo['username'],
    password => $repo['password'],
  }
}

