define :pyenv_package, package: nil, virtualenv: nil, version: nil, option: '' do
  package = params[:package] || params[:name]
  virtualenv = params[:virtualenv]
  version = params[:version]
  option = params[:option]

  activate_command = [
    'eval "$(pyenv init -)"',
    'eval "$(pyenv virtualenv-init -)"',
    "pyenv activate #{virtualenv}",
  ].join(' && ')

  execute [activate_command, "pip install #{option} #{package}"].join(' && ') do
    environment 'PYENV_ROOT' => node[:pyenv][:root],
                'PATH' => [
                  "#{node[:pyenv][:root]}/versions/#{version}/bin",
                  "#{node[:pyenv][:root]}/bin",
                  '/usr/bin',
                  '/bin',
                ].join(':')

    unless option.include?('--upgrade')
      not_if [
        [activate_command, 'pip list'].join(' && '),
        'cut -d " " -f 1',
        "grep -i #{package.split('==').first}",
        "grep #{package.split('==').last}",
      ].join(' | ')
    end
  end
end
