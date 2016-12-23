def emacs_installed?
  system("emacs --version | head -1 | grep '#{node[:emacs][:version]}'")
end
