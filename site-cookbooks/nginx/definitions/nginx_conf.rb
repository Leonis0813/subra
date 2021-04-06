define :nginx_conf do
  template "#{node[:nginx][:install_dir]}/conf.d/#{params[:name]}.conf" do
    source params[:source] || 'nginx.conf.erb'
    owner 'nginx'
    group 'nginx'
    mode '0644'
  end

  service 'nginx' do
    action :restart
  end
end
