default[:git][:requirements] = %w[curl-devel expat-devel gettext-devel openssl-devel zlib-devel perl-ExtUtils-MakeMaker]
default[:git][:version] = '2.11.0'
default[:git][:download] = {
  url: "https://www.kernel.org/pub/software/scm/git/git-#{default[:git][:version]}.tar.gz",
  dir: '/tmp',
  file: "git-#{default[:git][:version]}.tar.gz",
}
default[:git][:install_dir] = '/usr'
default[:git][:install_commands] = [
  "make prefix=#{default[:git][:install_dir]} all",
  "make prefix=#{default[:git][:install_dir]} install",
]
