class Chef::Recipe
  def rvm_installed?
    `rvm ; echo $?` == 0
  end
end
