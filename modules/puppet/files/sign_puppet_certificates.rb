puts "Signing puppet certificates"

waiting = %x[puppetca --list]

waiting.split("\n").each do |host|
   if host.match(/^\w+\d+/) || host.match(/^puppet/)
      puts "Signing certificate for #{host}"
      %x[puppetca --sign #{host}]
   end
end

