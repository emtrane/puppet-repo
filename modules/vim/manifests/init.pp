class vim {

   include bash

  file {
    "$env_home/.vimrc":
      ensure => file,
      source => "modules/vim/.vimrc";

    "$env_home/.vim":
      ensure => directory,
      recurse => true,
      source => "modules/vim/.vim";

  }
}

