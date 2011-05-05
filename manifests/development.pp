
Exec { path => $env_path }

$provider = "homebrew"

node default {
   #include puppet::slave
   include bash
   include ruby
   include python
   include vim
}

