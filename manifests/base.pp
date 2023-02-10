# basic setup for all rsyslog installations
class rsyslog::base {
  package { 'rsyslog':
    ensure => present,
  } -> file { '/etc/rsyslog.conf':
    source => ["puppet:///modules/site_rsyslog/config/${facts['networking']['fqdn']}/rsyslog.conf",
      "puppet:///modules/site_rsyslog/config/${facts['networking']['domain']}/rsyslog.conf",
      "puppet:///modules/site_rsyslog/config/${facts['os']['name']}/rsyslog.conf",
      'puppet:///modules/site_rsyslog/config/rsyslog.conf',
      "puppet:///modules/rsyslog/config/${facts['os']['name']}.${facts['os']['release']['major']}/rsyslog.conf",
      "puppet:///modules/rsyslog/config/${facts['os']['name']}/rsyslog.conf",
    'puppet:///modules/rsyslog/config/rsyslog.conf'],
    owner  => root,
    group  => 0,
    mode   => '0644';
  } ~> service { 'rsyslog':
    ensure    => running,
    enable    => true,
    hasstatus => true,
  }

  if versioncmp($facts['os']['release']['major'],'8') > 0 {
    package{'rsyslog-logrotate':
      ensure => present,
    }
  }
}
