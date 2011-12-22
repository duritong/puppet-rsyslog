class rsyslog::base {
    include syslog::disable

    package{'rsyslog':
        ensure => present,
    }
    service{rsyslog:
        ensure => running,
        enable => true,
        hasstatus => true,
        require => Package['rsyslog'],
    }
    file{'/etc/rsyslog.conf':
        source => [ "puppet:///modules/site-rsyslog/config/${fqdn}/rsyslog.conf",
                    "puppet:///modules/site-rsyslog/config/${domain}/rsyslog.conf",
                    "puppet:///modules/site-rsyslog/config/${operatingsystem}/rsyslog.conf",
                    "puppet:///modules/site-rsyslog/config/rsyslog.conf",
                    "puppet:///modules/rsyslog/config/${operatingsystem}.${lsbmajdistrelease}/rsyslog.conf",
                    "puppet:///modules/rsyslog/config/${operatingsystem}/rsyslog.conf",
                    "puppet:///modules/rsyslog/config/rsyslog.conf"],
        notify => Service['rsyslog'],
        require => Package['rsyslog'],
        owner => root, group => 0, mode => 0644;
    }
}