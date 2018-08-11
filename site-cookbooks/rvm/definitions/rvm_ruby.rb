define :rvm_ruby do
  version = params[:version] || params[:name]
  execute "rvm install #{version}" do
    environment 'PATH' => node[:rvm][:path]
  end
end
