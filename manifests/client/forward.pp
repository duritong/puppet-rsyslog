# simple forward rule
define rsyslog::client::forward (
  Enum['present','absent'] $ensure = 'present',
  Optional[String] $content = undef,
  Optional[Array[String,1]] $source = [
    "puppet:///modules/site_rsyslog/client/forwards/${facts['networking']['fqdn']}/${name}.conf",
    "puppet:///modules/site_rsyslog/client/forwards/${name}.conf",
    "puppet:///modules/rsyslog/client/forwards/${name}.conf",
  ],
) {
  rsyslog::confd { "03-fwd-${name}":
    ensure  => $ensure,
    content => $content,
    source  => $source,
  }
}
