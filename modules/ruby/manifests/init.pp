class ruby {

  include bash

#$rvm_ruby_packages = ["build-essential", "bison", "openssl", "libreadline5", "libreadline-dev", "zlib1g", "zlib1g-dev", "libssl-dev", "vim", "libsqlite3-0", "libsqlite3-dev", "sqlite3", "libreadline6-dev", "libxml2-dev", "git-core", "subversion", "autoconf"]
    $rvm_ruby_packages = []

# http://cjohansen.no/en/ruby/ruby_version_manager_ubuntu_and_openssl
    package {
      $rvm_ruby_packages:
        provider => "$provider",
                 ensure => "installed";
    }

# http://stackoverflow.com/questions/2578810/any-other-ways-to-install-heroku-except-gem-install/2582258#2582258

  $ruby_version = "ruby-1.9.2-p180"

    exec { 
      "install_rvm":
        command => "/tmp/rvm-install-system-wide.sh",
                require => File["/tmp/rvm-install-system-wide.sh"],
                unless => "ls /usr/local/bin/rvm";

# excessive doing this every time?
      "update_rvm":
        command => "rvm update --head && rvm reload",
                onlyif => "expr `date +%k` = '16'",
                require => Exec["install_rvm"];

      "install_ruby":
        command => "rvm install $ruby_version -C --disable-install-doc",
                require => [ Package[$rvm_ruby_packages], Exec["install_rvm"] ],
                unless => "rvm list | grep $ruby_version",
                timeout => 6000;

    }

  file {
# another hack, puppet didn't like the fancy bash tricks (see .sh file contents)
    "/tmp/rvm-install-system-wide.sh":
      mode => 777,
           content => template("ruby/rvm-install-system-wide.sh.erb");

  }
}

