def growl(message)
  growlnotify = `which growlnotify`.chomp
  title = "Watchr Test Results"
  /(?<num_failures>\d+)\sfailure/ =~ message
  passed = (num_failures.to_i == 0)
  image = passed ? "~/.watchr_images/passed.png" : "~/.watchr_images/failed.png"
  severity = passed ? "-1" : "1"
  options = "-w -n Watchr --image '#{File.expand_path(image)}'"
  options << " -m '#{message}' '#{title}' -p #{severity}"
  system %(#{growlnotify} #{options} &)
end

def run_spec(file)
  unless File.exist?(file)
    puts "#{file} does not exist"
    return
  end

  puts "Running #{file}"
  result = `bundle exec rspec #{file}`
  result.scan( Regexp.new('^\d+\sexample(?:s)?,\s\d+\sfailure(?:s)?') ).each do |line|    
    growl(line)
  end
  puts result
  puts
end

watch("spec/.*/*_spec.rb") do |match|
  run_spec match[0]
end

watch("lib/(.*/.*).rb") do |match|
  run_spec %{spec/models/#{match[1].split("/")[1]}_spec.rb}
end

watch("app/(.*/.*).rb") do |match|
  run_spec %{spec/#{match[1]}_spec.rb}
end