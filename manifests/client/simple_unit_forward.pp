# simple forward of a unit
define rsyslog::client::simple_unit_forward (
  Enum['present','absent'] $ensure = 'present',
  String $unit_name = $title,
) {
  rsyslog::client::forward { $name:
    ensure  => $ensure,
    content => epp('rsyslog/client/simple_unit_forward.epp', {
      unit_name => $unit_name
    })
  }
}
