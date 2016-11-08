class once ($state_dir = '/var/lib/puppet-execonce') {
  class {'::once::config':
    state_dir => $state_dir,
  }
  if !defined(File[$state_dir]) {
    file { $state_dir:
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
    }
  }
}
