define :pyenv_package, package: nil, virtualenv: nil, version: nil do
  package = params[:package] || params[:name]
  virtualenv = params[:virtualenv] || ''
  version = params[:version]

  execute "pyenv global #{version} #{virtualenv} && pip install #{package}" do
    environment 'PYENV_ROOT' => node[:pyenv][:root],
                'PATH' => [
                  "#{node[:pyenv][:root]}/versions/#{version}/bin",
                  "#{node[:pyenv][:root]}/bin",
                  '/usr/bin',
                  '/bin',
                ].join(':')
    not_if [
      "pyenv global #{version} #{virtualenv} && pip list",
      'cut -d " " -f 1',
      "grep -i #{package.split('==').first}",
    ].join(' | ')
  end
end
