# enable anonymization
class rsyslog::mmanon {
  rsyslog::confd{
    'mmanon':
      ensure => absent;
    '00-mmanon':
      source    => 'puppet:///modules/rsyslog/config/mmanon.conf';
  }
}
