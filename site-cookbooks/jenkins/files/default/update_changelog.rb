require 'date'

CHANGELOG = ARGV[0]
lines = File.read(CHANGELOG).lines
versions = lines.first.match(/\A#\s(\d+)\.(\d+)\.(\d+)/)[1..3]

File.open(CHANGELOG, 'w') do |file|
  file.puts <<"EOF"
# #{versions[0]}.#{versions[1]}.#{versions[2].to_i + 1} (#{Date.today.strftime('%Y/%m/%d')})
- [UPDATE] gems

EOF
  lines.each {|line| file.puts(line) }
end
