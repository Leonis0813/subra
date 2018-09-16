default[:tensorflow][:url] = 'https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.10.1-cp36-cp36m-linux_x86_64.whl'
default[:tensorflow][:requirements] = {
  :base_url => 'http://copr-be.cloud.fedoraproject.org/results/mosquito/myrepo-el6/epel-6-x86_64/glibc-2.17-55.fc20',
  :packages => [
    'glibc-2.17-55.el6.x86_64.rpm',
    'glibc-common-2.17-55.el6.x86_64.rpm',
    'glibc-devel-2.17-55.el6.x86_64.rpm',
    'glibc-headers-2.17-55.el6.x86_64.rpm',
  ],
}
default[:tensorflow][:pyenv] = {
  :root => '/usr/local/pyenv',
  :repository => 'https://github.com/pyenv/pyenv.git',
  :revision => 'v1.2.6',
}
default[:tensorflow][:python][:version] = '3.6.0'
