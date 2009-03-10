class rsyslog::server::base inherits rsyslog::base {
    File['/etc/rsyslog.conf']{
        source => [ "puppet://$server/files/rsyslog/server/config/${fqdn}/rsyslog.conf",
                    "puppet://$server/files/rsyslog/server/config/${domain}/rsyslog.conf",
                    "puppet://$server/files/rsyslog/server/config/${operatingsystem}/rsyslog.conf",
                    "puppet://$server/files/rsyslog/server/config/rsyslog.conf",
                    "puppet://$server/rsyslog/server/config/${operatingsystem}/rsyslog.conf",
                    "puppet://$server/rsyslog/server/config/rsyslog.conf"],
    }

    include logrotate
    logrotate::snippet{'rsyslog-remote':
        source => "puppet:://$server/rsyslog/logrotate/server/rsyslog-remote",
    }
}
