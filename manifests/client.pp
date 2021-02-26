# deploy a simple tls enabled relp client
class rsyslog::client (
  Sensitive[String] $private_key,
  String $cert,
  String $ca,
  Stdlib::Fqdn $log_server,
  Rsyslog::Forwards $forwards = { 'auth' => {} },
) {
  include rsyslog
  $conf_options = {
    log_server => $log_server,
  }
  ensure_packages(['rsyslog-gnutls','rsyslog-relp'])
  file {
    default:
      owner   => root,
      group   => 0,
      mode    => '0440',
      require => Package['rsyslog','rsyslog-gnutls','rsyslog-relp'],
      notify  => Service['rsyslog'];
    '/etc/pki/rsyslog/ca-client.pem':
      content => $ca;
    '/etc/pki/rsyslog/client.pem':
      content => $cert;
    '/etc/pki/rsyslog/client.key':
      content => $private_key;
    '/etc/rsyslog.d/02-client.conf':
      content => epp('rsyslog/client/conf.epp',$conf_options);
  }

  if !empty($forwards) {
    $forwards.each |$f,$d| {
      rsyslog::client::forward { $f:
        * => $d,
      }
    }
  }
  include rsyslog::client::auditd
  class { 'firewall::rules::out::rsyslog':
    server => resolv($log_server),
  }
}
