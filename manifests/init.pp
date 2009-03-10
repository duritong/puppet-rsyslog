#
# rsyslog module
#
# Copyright 2008, Puzzle ITC
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

class rsyslog {
    case $operatingsystem {
        centos: { include rsyslog::base }
        default: { include rsyslog::centos }
    }
}

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
        source => [ "puppet://$server/files/rsyslog/config/${fqdn}/rsyslog.conf",
                    "puppet://$server/files/rsyslog/config/${domain}/rsyslog.conf",
                    "puppet://$server/files/rsyslog/config/${operatingsystem}/rsyslog.conf",
                    "puppet://$server/files/rsyslog/config/rsyslog.conf",
                    "puppet://$server/rsyslog/config/${operatingsystem}/rsyslog.conf",
                    "puppet://$server/rsyslog/config/rsyslog.conf"],
        notify => Service['rsyslog'],
        require => Package['rsyslog'],
        owner => root, group => 0, mode => 0644;
    }

}

class rsyslog::centos inherits rsyslog::base {
    file{'/etc/sysconfig/rsyslog':
        source => [ "puppet://$server/files/rsyslog/config/CentOS/${fqdn}/rsyslog",
                    "puppet://$server/files/rsyslog/config/CentOS/rsyslog.${lsbdistrelease}",
                    "puppet://$server/files/rsyslog/config/CentOS/rsyslog",
                    "puppet://$server/rsyslog/config/CentOS/rsyslog.${lsbdistrelease}",
                    "puppet://$server/rsyslog/config/CentOS/rsyslog" ],
        notify => Service['rsyslog'],
        owner => root, group => 0, mode => 0644;
    }
}
