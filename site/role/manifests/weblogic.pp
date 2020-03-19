class role::weblogic {

  #This role would be made of all the profiles that need to be included to make a webserver work
  #All roles should include the base profile
  #contain "::profile::base::linux${facts[os][family]}${facts[os][release][major]}"
  #contain profile::base::linux
  contain profile::weblogic

}

