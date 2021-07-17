# simple forward of a unit
define rsyslog::client::simple_forward (
  Enum['present','absent'] $ensure = 'present',
  String $unit_name = $title,
) {
  rsyslog::forward { $name:
    ensure  => $ensure,
    content => epp('rsyslog/client/simple_forward.epp', {
      unit_name => $unit_name
    })
  }
}
