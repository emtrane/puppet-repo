
node default {
   include forge
   include puppet::master
   include puppet::slave
}

Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin" }

