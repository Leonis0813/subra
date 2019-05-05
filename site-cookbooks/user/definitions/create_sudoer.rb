define :create_sudoer do
  template "/etc/sudoers.d/#{params[:name]}" do
    cookbook 'user'
    source 'sudoers.erb'
    owner 'root'
    group 'root'
    mode '0440'
    variables(user_name: params[:name])
  end
end
