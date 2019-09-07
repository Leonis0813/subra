define :rvm_gem,
       ruby_version: nil, gemset: nil, gem_version: nil, gem_name: nil, force: false do
  gem_version = params[:gem_version] ? "-v #{params[:gem_version]}" : ''
  gem_name = params[:gem_name] || params[:name]
  force = params[:force] == true ? '--force' : ''
  rvm_do = "rvm #{params[:ruby_version]}@#{params[:gemset]} do"

  execute "#{rvm_do} gem install #{gem_name} #{gem_version} #{force}" do
    environment 'PATH' => node[:rvm][:path]
  end
end
