default[:git][:requirements] = %w[
  curl-devel
  expat-devel
  gcc
  gettext-devel
  make
  openssl-devel
  zlib-devel
  perl-ExtUtils-MakeMaker
]
default[:git][:version] = '2.11.0'
default[:git][:download][:dir] = '/tmp'
default[:git][:download][:file] = "git-#{default[:git][:version]}.tar.gz"
default[:git][:download][:url] =
  "https://www.kernel.org/pub/software/scm/git/#{default[:git][:download][:file]}"
default[:git][:install_dir] = '/usr'
default[:git][:install_commands] = [
  "make prefix=#{default[:git][:install_dir]} all",
  "make prefix=#{default[:git][:install_dir]} install",
]
