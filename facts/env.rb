# http://projects.puppetlabs.com/projects/1/wiki/Environment_Variables_Patterns

ENV.each do |k,v|
   Facter.add("env_#{k.downcase}".to_sym) do
      setcode do
         v
      end
   end
end

