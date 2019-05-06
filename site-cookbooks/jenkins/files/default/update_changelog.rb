require 'date'

CHANGELOG = ARGV[0]
lines = File.read(CHANGELOG).lines
versions = lines.first.match(/\A#\s(\d+)\.(\d+)\.(\d+)/)[1..3]
commands = [
  "cd #{File.dirname(CHANGELOG)} && git diff develop --name-only",
  'grep "CHANGELOG"',
]
changed = system(commands.join(' | '))

File.open(CHANGELOG, 'w') do |file|
  today = Date.today.strftime('%Y/%m/%d')

  if changed
    lines[0].sub!(%r{\d{4}/\d{2}/\d{2}}, today)
  else
    file.puts <<-"CHANGELOG"
# #{versions[0]}.#{versions[1]}.#{versions[2].to_i + 1} (#{today})
- [UPDATE] gems

    CHANGELOG
  end
  lines.each {|line| file.puts(line) }
end
