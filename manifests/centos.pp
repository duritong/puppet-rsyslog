class rsyslog::centos inherits rsyslog::base {
    file{'/etc/sysconfig/rsyslog':
        source => [ "puppet:///modules/site-rsyslog/config/CentOS/${fqdn}/rsyslog",
                    "puppet:///modules/site-rsyslog/config/CentOS/rsyslog.${lsbdistrelease}",
                    "puppet:///modules/site-rsyslog/config/CentOS/rsyslog",
                    "puppet:///modules/rsyslog/config/CentOS/rsyslog.${lsbdistrelease}",
                    "puppet:///modules/rsyslog/config/CentOS/rsyslog" ],
        notify => Service['rsyslog'],
        owner => root, group => 0, mode => 0644;
    }
}