def git_installed?
  system("git --version | head -1 | grep '#{node[:git][:version]}'")
end
