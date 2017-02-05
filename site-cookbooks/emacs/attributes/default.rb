default[:emacs][:requirements] = %w[ gcc make ncurses-devel ]
default[:emacs][:version] = '24.5'
default[:emacs][:download] = {
  :url => "http://ftp.gnu.org/pub/gnu/emacs/emacs-#{node[:emacs][:version]}.tar.gz",
  :dir => '/tmp',
  :file => "emacs-#{default[:emacs][:version]}.tar.gz",
}
