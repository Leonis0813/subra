require 'date'

CHANGELOG = ARGV[0]
lines = File.read(CHANGELOG).lines
versions = lines.first.match(/\A#\s(\d+)\.(\d+)\.(\d+)/)[1..3]
changed = system("cd #{File.dirname(CHANGELOG)} && git diff develop --name-only | grep 'CHANGELOG'")

File.open(CHANGELOG, 'w') do |file|
  today = Date.today.strftime('%Y/%m/%d')

  if changed
    lines[0].sub!(/\d{4}\/\d{2}\/\d{2}/, today)
  else
    file.puts <<"EOF"
# #{versions[0]}.#{versions[1]}.#{versions[2].to_i + 1} (#{today})
- [UPDATE] gems

EOF
  end
  lines.each {|line| file.puts(line) }
end
