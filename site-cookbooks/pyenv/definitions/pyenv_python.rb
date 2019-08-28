define :pyenv_python, version: nil do
  version = params[:version] || params[:name]

  execute "pyenv install #{version}" do
    environment 'PYENV_ROOT' => node[:pyenv][:root],
                'PATH' => "#{node[:pyenv][:root]}/bin:/usr/bin:/bin"
    not_if { File.exist?("#{node[:pyenv][:root]}/versions/#{version}") }
  end
end
