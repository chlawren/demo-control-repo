class profile::login_defs (
  Hash      $options,
){

  class{'login_defs':
    options => $options,
  }
}

