# manage config snippet
define rsyslog::confd(
  Enum['present','absent'] $ensure = 'present',
  Optional[String]         $source = undef,
  Optional[String]         $content = undef,
) {
  if ($ensure == 'present') and !($source or $content) {
    fail("Requires either source or content")
  }
  include ::rsyslog
  file{"/etc/rsyslog.d/${name}.conf":
    require => Package['rsyslog'],
    notify  => Service['rsyslog'],
  }
  if $ensure == 'present' {
    File["/etc/rsyslog.d/${name}.conf"]{
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
  } else {
    File["/etc/rsyslog.d/${name}.conf"]{
      ensure => 'absent',
    }
  }
}
