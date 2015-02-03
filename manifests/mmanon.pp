# enable anonymization
class rsyslog::mmanon {
  include ::rsyslog
  file{'/etc/rsyslog.d/mmanon.conf':
    source    => 'puppet:///modules/rsyslog/config/mmanon.conf',
    require   => Package['rsyslog'],
    notify    => Service['rsyslog'],
    owner     => root,
    group     => 0,
    mode      => '0644',
  }
}
