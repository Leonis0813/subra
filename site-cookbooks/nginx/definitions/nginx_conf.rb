define :nginx_conf do
  source_file_path = param[:source] || File.absolute_path(
    "#{File.dirname(__FILE__)}/../../#{param[:name]}/templates/default/nginx.conf.erb"
  )

  template "#{node[:nginx][:install_dir]}/conf.d/#{param[:name]}.conf" do
    source source_file_path
    owner 'nginx'
    group 'nginx'
    mode '0644'
    variables(nginx_apps: node[:nginx][:apps])
  end

  service 'nginx' do
    action :restart
  end
end
