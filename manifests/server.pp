# deploy a simple tls enabled relp server
class rsyslog::server (
  Sensitive[String] $private_key,
  String $cert,
  String $ca,
  Array[String,1] $permitted_peers = ["*.${facts['networking']['domain']}"],
) {
  include rsyslog
  $conf_options = {
    permitted_peers => $permitted_peers,
  }
  ensure_packages(['rsyslog-gnutls'])
  package { ['rsyslog-relp','rsyslog-mmjsonparse','rsyslog-mmaudit',
    'rsyslog-mmnormalize']:
      ensure  => installed,
      require => Package['rsyslog-gnutls'],
  } -> file {
    default:
      owner   => root,
      group   => 0,
      mode    => '0440',
      require => Package['rsyslog'],
      notify  => Service['rsyslog'];
    '/etc/pki/rsyslog/ca-server.pem':
      content => $ca;
    '/etc/pki/rsyslog/server.pem':
      content => $cert;
    '/etc/pki/rsyslog/server.key':
      content => $private_key;
    '/etc/rsyslog.d/01-server.conf':
      content => epp('rsyslog/server/conf.epp',$conf_options);
  }
  nftables::simplerule { 'rsyslog_relp':
    action  => 'accept',
    comment => 'allow traffic to port 20514',
    proto   => 'tcp',
    dport   => 20514,
    before  => Service['rsyslog'],
  }
}
