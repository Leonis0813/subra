define :rvm_ruby, version: nil do
  version = params[:version] || params[:name]
  execute "rvmsudo rvm install #{version}" do
    environment 'PATH' => node[:rvm][:path]
  end
end
