# manages auditd related forward config
class rsyslog::client::auditd {
  if versioncmp($facts['os']['release']['major'],'8') >= 0 {
    package { 'audispd-plugins':
      ensure => installed,
    } -> File_line['auditd_syslog_active','auditd_syslog_args']
    $audit_syslog_file = '/etc/audit/plugins.d/syslog.conf'
  } else {
    $audit_syslog_file = '/etc/audisp/plugins.d/syslog.conf'
  }
  file_line {
    default:
      path => $audit_syslog_file;
    'auditd_syslog_active':
      line    => 'active = yes',
      pattern => '^active';
    'auditd_syslog_args':
      line    => 'args = LOG_INFO LOG_LOCAL3',
      pattern => '^args';
  } ~> exec { 'reload_auditd':
    # https://access.redhat.com/solutions/2664811
    command     => 'service auditd restart',
    refreshonly => true,
    require     => Service['rsyslog'];
  }

  rsyslog::client::forward { 'auditd': }
}
