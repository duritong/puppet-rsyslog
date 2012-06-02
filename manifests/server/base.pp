class rsyslog::server::base inherits rsyslog::base {
  File['/etc/rsyslog.conf']{
    source => [ "puppet:///modules/site_rsyslog/server/config/${::fqdn}/rsyslog.conf",
                "puppet:///modules/site_rsyslog/server/config/${::domain}/rsyslog.conf",
                "puppet:///modules/site_rsyslog/server/config/${::operatingsystem}/rsyslog.conf",
                "puppet:///modules/site_rsyslog/server/config/rsyslog.conf",
                "puppet:///modules/rsyslog/server/config/${::operatingsystem}/rsyslog.conf",
                "puppet:///modules/rsyslog/server/config/rsyslog.conf"],
  }

  include logrotate
  logrotate::snippet{'rsyslog-remote':
    source => "puppet::///modules/rsyslog/logrotate/server/rsyslog-remote",
  }
}
