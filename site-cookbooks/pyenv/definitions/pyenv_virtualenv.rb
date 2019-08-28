define :pyenv_virtualenv, env_name: nil, version: nil do
  env_name = params[:env_name] || params[:name]
  version = params[:version]

  command = [
    'eval "$(pyenv init -)"',
    'eval "$(pyenv virtualenv-init -)"',
    "pyenv virtualenv #{version} #{env_name}",
  ].join(' && ')

  execute command do
    environment 'PYENV_ROOT' => node[:pyenv][:root],
                'PATH' => "#{node[:pyenv][:root]}/bin:/usr/bin:/bin"
    not_if { File.exist?("#{node[:pyenv][:root]}/versions/#{version}/envs/#{env_name}") }
  end
end
