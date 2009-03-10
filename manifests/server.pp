class rsyslog::server {
    case $operatingsystem {
        centos: { include rsyslog::server::base }
        default: { include rsyslog::server::centos }
    }
}
