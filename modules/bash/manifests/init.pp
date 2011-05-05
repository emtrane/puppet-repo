class bash {

   #Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin" }

   file {
      "$env_home/.bashrc":
         content => template("bash/bashrc.erb");

      "$env_home/.gemrc":
         content => "gem: --no-ri --no-rdoc";
   }

   package {
      ["htop"]:
         ensure => "installed",
         provider => "$provider";
   }

}

