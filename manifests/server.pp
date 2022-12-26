# deploy a simple tls enabled relp server
class rsyslog::server (
  Sensitive[String] $private_key,
  String $cert,
  String $ca,
  Array[String,1] $permitted_peers = ["*.${facts['networking']['domain']}"],
  Struct[{ on_calendar => Optional[String], randomize_delay_sec => Optional[String] }] $compress_timer = {},
  Hash[String[1], String[1]] $prognames_to_log = {}
) {
  include rsyslog
  if versioncmp($facts['os']['release']['major'],'9') < 0 {
    class { 'rsyslog::repo':
      stage => 'yum',
    }
    $with_mmrm1stspace = true
    package {'rsyslog-mmrm1stspace':
      ensure  => present,
      require => Package['rsyslog-gnutls'],
      before  => Package['rsyslog-mmjsonparse'],
    }
  } else {
    $with_mmrm1stspace = false
  }
  $conf_options = {
    permitted_peers  => $permitted_peers,
    prognames_to_log => $prognames_to_log,
    mmrm1stspace     => $with_mmrm1stspace,
  }
  ensure_packages(['rsyslog-gnutls','rsyslog-relp'])
  package { ['rsyslog-mmjsonparse','rsyslog-mmaudit',
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
  file { '/usr/local/sbin/rsyslog-compress-remote.sh':
    source  => 'puppet:///modules/rsyslog/server/rsyslog-compress-remote.sh',
    owner   => root,
    group   => 0,
    mode    => '0750',
    require => Service['rsyslog'],
  } -> systemd::timer { 'rsyslog-compress-remotes.timer':
    timer_content   => epp('rsyslog/server/compress.timer.epp', $compress_timer),
    service_content => epp('rsyslog/server/compress.service.epp'),
    active          => true,
    enable          => true,
  }
}
