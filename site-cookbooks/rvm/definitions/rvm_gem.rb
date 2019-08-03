define :rvm_gem, ruby_version: nil, gemset: nil, gem_version: nil, gem_name: nil do
  ruby_version = params[:ruby_version]
  gemset = params[:gemset]
  gem_version = params[:gem_version] ? "-v #{params[:gem_version]}" : ''
  gem_name = params[:gem_name] || params[:name]
  execute "rvm #{ruby_version}@#{gemset} do gem install #{gem_name} #{gem_version}" do
    environment 'PATH' => node[:rvm][:path]
  end
end
