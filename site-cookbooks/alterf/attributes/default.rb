default[:alterf][:app_name] = 'alterf'
default[:alterf][:deploy_dir] = "/opt/#{default[:alterf][:app_name]}"
default[:alterf][:repository] = "https://github.com/Leonis0813/#{default[:alterf][:app_name]}.git"
default[:alterf][:branch] = 'develop'
default[:alterf][:symlinks] = {'log' => 'log', 'backup' => 'backup'}
default[:alterf][:shared_dirs] = %w[ backup/race_list backup/races backup/horses log bundle ]
default[:alterf][:cron_settings] = [
  {:name => 'import', :hour => '0', :minute => '0'},
  {:name => 'aggregate', :hour => '0', :minute => '5'},
]
default[:alterf][:cron_paths] = [
  '/usr/local/rvm/gems/ruby-2.2.0@global/bin',
  '/usr/local/rvm/rubies/ruby-2.2.0/bin',
  '/usr/bin',
  '/bin',
]
default[:alterf][:ruby_version] = '2.2.0'
