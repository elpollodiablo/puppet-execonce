define once::exec (
  $cwd         = undef,
  $environment = undef,
  $group       = undef,
  $logoutput   = undef,
  $onlyif      = undef,
  $path        = undef,
  $provider    = undef,
  $refresh     = undef,
  $refreshonly = undef,
  $returns     = undef,
  $timeout     = undef,
  $tries       = undef,
  $try_sleep   = undef,
  $umask       = undef,
  $unless      = undef,
  $user        = undef,
  $state_dir   = undef,
  $command     = $name,
) {

  include once

  if $state_dir {
    $my_state_dir = $state_dir
  } else {
    $my_state_dir = $::once::config::state_dir
  }
  
  $cmd_checksum = sha1(join([$title, $command]))
  $cmd_pathsafe = regsubst($title, '[^0-9A-Za-z.\-]', '_', 'G')
  $state_file = join([$cmd_pathsafe, $cmd_checksum], '_')
  $state_file_path = join([$my_state_dir, $state_file], '/')

  exec { $name:
    command     => $command,
    cwd         => $cwd,
    environment => $environment,
    group       => $group,
    logoutput   => $logoutput,
    onlyif      => $onlyif,
    path        => $path,
    provider    => $provider,
    refresh     => $refresh,
    refreshonly => $refreshonly,
    returns     => $returns,
    timeout     => $timeout,
    tries       => $tries,
    try_sleep   => $try_sleep,
    umask       => $umask,
    unless      => $unless,
    user        => $user,
    creates     => $state_file_path,
  } -> 
  file { $state_file_path:
    ensure      => file,
    owner       => 'root',
    group       => 'root',
    mode        => '0644',
    require     => File[$my_state_dir],
  }
}
