type Rsyslog::Forwards = Hash[String[1],
  Struct[{
    Optional[ensure]  => Enum['present','absent'],
    Optional[content] => String[1],
    Optional[source]  => Array[String[1]],
  }]
]
