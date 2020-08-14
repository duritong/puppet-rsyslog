# enable anonymization
class rsyslog::mmanon {
  rsyslog::confd{
    '00-mmanon':
      source    => 'puppet:///modules/rsyslog/config/mmanon.conf';
  }
}
