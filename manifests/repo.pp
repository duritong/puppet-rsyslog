# manage upstream repo
class rsyslog::repo {
  yum::repo { 'rsyslog':
    descr         => 'Adiscon CentOS-$releasever - local packages for $basearch',
    baseurl       => 'http://rpms.adiscon.com/v8-stable/epel-$releasever/$basearch',
    enabled       => 1,
    gpgcheck      => 1,
    priority      => 1,
    repo_gpgcheck => 1,
    protect       => 1,
    gpgkey_source => 'puppet:///modules/rsyslog/RPM-GPG-KEY-Adiscon',
    gpgkeyid      => 'E00B8985',
    gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Adiscon',
  } ~> exec { 'update_rsyslog':
    refreshonly => true,
  }
  if versioncmp($facts['os']['release']['major'],'8') >= 0 {
    Exec['update_rsyslog'] {
      command => 'dnf update -y rsyslog',
    }
  } else {
    Exec['update_rsyslog'] {
      command => 'yum update -y rsyslog',
    }
  }
}
