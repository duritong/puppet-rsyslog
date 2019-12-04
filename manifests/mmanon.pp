# enable anonymization
class rsyslog::mmanon {
  rsyslog::confd{
    # TODO: remove once this ran for a while
    'mmanon':
      ensure => absent;
    '00-mmanon':
      source    => 'puppet:///modules/rsyslog/config/mmanon.conf';
  }
}
