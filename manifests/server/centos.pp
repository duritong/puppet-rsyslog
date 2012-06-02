class rsyslog::server::centos inherits rsyslog::centos {
  include rsyslog::server::base
  File['/etc/sysconfig/rsyslog']{
    source => [ "puppet:///modules/site_rsyslog/server/config/CentOS/${::fqdn}/rsyslog",
                "puppet:///modules/site_rsyslog/server/config/CentOS/rsyslog.${::lsbdistrelease}",
                "puppet:///modules/site_rsyslog/server/config/CentOS/rsyslog",
                "puppet:///modules/rsyslog/server/config/CentOS/rsyslog.${::lsbdistrelease}",
                "puppet:///modules/rsyslog/server/config/CentOS/rsyslog" ],
  }
}

