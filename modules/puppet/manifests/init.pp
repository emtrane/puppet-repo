
class puppet::master {
    
    include forge
    include puppet::slave

    package {
        ["capistrano", "nokogiri", "rest-client"]:
            ensure => installed,
            require => Class[forge], # the forge class will disable installing docs via /etc/gemrc
            provider => "gem";
    }

    exec {
      "puppetmasterd":
         command => "puppetmasterd --mkusers --debug",
         unless => "ps -ef | grep -v grep | grep puppetmasterd";
    }

   cron { "sign_puppet_certificates":
     ensure  => present,
     command => "ruby /etc/puppet/modules/puppet/files/sign_puppet_certificates.rb >> /var/log/shortcast.log 2>&1",
     user    => 'root',
     minute  => '*/15',
     require => Exec["puppetmasterd"];

   "setup_dns":
     ensure  => present,
     command => "cd /var/build/current/rightscale && cap shortcast:setup_dns -S environment=$environment >> /var/log/shortcast.log 2>&1",
     user    => 'root',
     minute  => '*/15',
     require => Exec["puppetmasterd"];
   }
}

class puppet::slave {
   cron { "run_puppetd":
     ensure  => present,
     command => "puppetd --onetime --no-daemonize --debug --logdest syslog >> /var/log/shortcast.log 2>&1",
     user    => 'root',
     minute  => ip_to_minutes(4)
   }
}

