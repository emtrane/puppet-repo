Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/var/lib/gems/1.8/bin" }

node default {
   include forge
   include puppet::slave
}

node "puppet" inherits default {
   include puppet::master
   include loadbalancer
   include queue
   include clock
   include build
   include mongodb
   include java
   include api
   include ruby
   include cmdline

   # scp -i key key root@ip:/root/.ssh/alpha
   # scp -i key -r shortcast /var/build
   # scp -i key -r /var/build 184.72.5.48:/var/
   # ssh -i key root@ip "cp -r /var/build/puppet /etc/"
   # ssh -i key root@ip "groupadd puppet"
   # ssh -i key root@ip "puppet /etc/puppet/manifests/puppetmaster.pp"
}

node /^db\d+/ inherits default {
   include mongodb
}

node /^api\d+/ inherits default {
   include java
   include api
}

node /^web\d+/ inherits default {
   include ruby
}

node /^cmd\d+/ inherits default {
   include java
   include cmdline
}

node /^lb\d+/ inherits default {
   include loadbalancer
}

node "puppet.internal" inherits "puppet" {
   include mongodb
   include java
   include api
   include ruby
   include cmdline
}

node /^slave\d+/ inherits default {
   include mongodb
   include java
   include api
   include ruby
   include cmdline
   include build
}

# hadoop - http://serverfault.com/questions/115148/hadoop-slaves-file-necessary

