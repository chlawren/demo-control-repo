class profile::rsyslog (
  Boolean   $log_local,
  String    $remote_type,
  Array     $remote_servers,
){

  class{'rsyslog::client':
    log_local      => $log_local,
    remote_type    => $remote_type,
    remote_servers => [ $remote_servers ],
  }
}

