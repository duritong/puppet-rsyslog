class rsyslog::server::centos inherits rsyslog::centos {
    include rsyslog::server::base
    File['/etc/sysconfig/rsyslog']{
        source => [ "puppet://$server/files/rsyslog/server/config/CentOS/${fqdn}/rsyslog",
                    "puppet://$server/files/rsyslog/server/config/CentOS/rsyslog.${lsbdistrelease}",
                    "puppet://$server/files/rsyslog/server/config/CentOS/rsyslog",
                    "puppet://$server/rsyslog/server/config/CentOS/rsyslog.${lsbdistrelease}",
                    "puppet://$server/rsyslog/server/config/CentOS/rsyslog" ],
    }
}

