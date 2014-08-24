# centos specific stuff
class rsyslog::centos inherits rsyslog::base {
  file{'/etc/sysconfig/rsyslog':
    source  => ["puppet:///modules/site_rsyslog/config/CentOS/${::fqdn}/rsyslog",
                "puppet:///modules/site_rsyslog/config/CentOS/rsyslog.${::operatingsystemmajrelease}",
                'puppet:///modules/site_rsyslog/config/CentOS/rsyslog',
                "puppet:///modules/rsyslog/config/CentOS/rsyslog.${::operatingsystemmajrelease}",
                'puppet:///modules/rsyslog/config/CentOS/rsyslog' ],
    notify  => Service['rsyslog'],
    owner   => root,
    group   => 0,
    mode    => '0644';
  }
}
