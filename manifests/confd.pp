# manage config snippet
define rsyslog::confd(
  Optional[String] $source = undef,
  Optional[String] $content = undef,
) {
  if !($source or $content) {
    fail("Requires either source or content")
  }
  include ::rsyslog
  file{"/etc/rsyslog.d/${name}.conf":
    require => Package['rsyslog'],
    notify  => Service['rsyslog'],
    owner   => root,
    group   => 0,
    mode    => '0640',
  }
  if $source {
    File["/etc/rsyslog.d/${name}.conf"]{
      source => $source,
    }
  } else {
    File["/etc/rsyslog.d/${name}.conf"]{
      content => $content,
    }
  }
}
