default[:nfs][:services] = %w[ nfs rpcbind nfslock ]
default[:nfs][:actions] = [:start, :enable]
