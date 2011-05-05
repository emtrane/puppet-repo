class python {

   include bash

    package {
      "python3":
        provider => "$provider",
        ensure => "installed";
    }

}

