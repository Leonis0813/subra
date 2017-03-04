define :create_sudoer do
  template "/etc/sudoers.d/#{user_name}" do
    source 'sudoers.erb'
    owner node[:regulus][:username]
    group node[:regulus][:username]
    mode 0600
    variables(:user_name => params[:name])
  end
end
