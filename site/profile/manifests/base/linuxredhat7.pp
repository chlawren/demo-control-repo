class profile::base::linuxredhat7 (
  Boolean $auditd_service_enable = $profile::base::linuxredhat7::auditd_service_enable,
  String $auditd_service_ensure = $profile::base::linuxredhat7::auditd_service_ensure,
){

  # This base profile should only include modules used for RHEL 7
  include ::aide
  include ::anacron
  include ::apmd
  include ::atd
  include ::autofs
  include ::benchmark
  include ::abrtd
  include ::acpid
  include ::cups
  include ::gpm
  include ::haldaemon
  include ::kdump
  include ::mdmonitor
  include ::microcode_ctl
  include ::ntpdate
  include ::portreserve
  include ::postfix
  include ::restorecond
  include ::rpc
  include ::smartd
  include ::tcp_wrappers
  include ::xinetd
  include ::ypbind
  include ::ilmt

  class { '::auditd':
    service_ensure => $auditd_service_ensure,
    service_enable => $auditd_service_enable,
  }

  file { '/root/tmp' :
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }


  file_line { 'add_root_bashrc_line':
    ensure            => present,
    path              => '/root/.bashrc',
    line              => "export TMPDIR=~/tmp\n",
    match             => '^export TMPDIR=\~\/tmp',
    match_for_absence => true,
  }

