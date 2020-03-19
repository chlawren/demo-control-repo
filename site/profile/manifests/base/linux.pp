class profile::base::linux {

  #the base profile should include component modules that will be on all nodes
  include ::ntp
  include ::ssh
  include ::timezone
  include ::selinux
  include ::rsyslog::client
  include ::lvm
  include ::login_defs
  include ::accounts
  include ::pam
  include ::pam::limits
  include ::dnsclient
  include ::metricbeat


  logrotate::rule { 'sudo':
    path         => '/var/log/sudo.log',
    rotate       => 6,
    rotate_every => 'month',
    compress     => true,
    dateext      => true,
    postrotate   => 'usr/bin/killall -HUP syslogd',
  }

  if $facts[fqdn] == 'puppet.demo.com' {
    logrotate::rule { 'git_pull':
      path         => '/var/log/git_pull.log',
      rotate       => 6,
      rotate_every => 'week',
      compress     => true,
      dateext      => true,
    }
  }

  cron::job { 'vmstat':
    minute  => '0',
    hour    => '0',
    command => '/sysman/operators/start_vmstat 4500 2>/dev/null',
    }
}
