class role::puppet_master {
  include "::profile::base::linux${facts[os][family]}${facts[os][release][major]}"
  include ::profile::base::linux
  include ::profile::puppet_master


}
