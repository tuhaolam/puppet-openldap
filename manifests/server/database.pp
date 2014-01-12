# See README.md for details.
define openldap::server::database(
  $directory,
  $suffix  = $title,
  $backend = undef,
  $rootdn  = undef,
  $rootpw  = undef,
) {
  validate_absolute_path($directory)

  if $::openldap::server::provider == 'augeas' {
    Class['openldap::server::install'] ->
    Openldap::Server::Database[$title] ~>
    Class['openldap::server::service']
  } else {
    Class['openldap::server::service'] ->
    Openldap::Server::Database[$title] ->
    Class['openldap::server']
  }

  openldap_database { $title:
    suffix    => $suffix,
    provider  => $::openldap::server::provider,
    target    => $::openldap::server::file,
    backend   => $backend,
    directory => $directory,
    rootdn    => $rootdn,
    rootpw    => $rootpw,
  }
}
