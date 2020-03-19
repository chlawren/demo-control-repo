class role::generic_linux_server {

  include "::profile::base::linux${facts[os][family]}${facts[os][release][major]}"
  include ::profile::base::linux

}
