# enable anonymization
class rsyslog::mmanon {
  rsyslog::confd{'mmanon':
    source    => 'puppet:///modules/rsyslog/config/mmanon.conf',
  }
}
