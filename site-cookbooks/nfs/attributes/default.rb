default[:nfs][:services] = %w[ rpcbind nfs nfslock ]
default[:nfs][:iptable_settings] = [
  {:append => 'INPUT', :proto => 'tcp', :dport => '111', :jump => 'ACCEPT'},
  {:append => 'INPUT', :proto => 'udp', :dport => '111', :jump => 'ACCEPT'},
  {:append => 'INPUT', :proto => 'tcp', :dport => '875', :jump => 'ACCEPT'},
  {:append => 'INPUT', :proto => 'udp', :dport => '875', :jump => 'ACCEPT'},
  {:append => 'INPUT', :proto => 'tcp', :dport => '2049', :jump => 'ACCEPT'},
  {:append => 'INPUT', :proto => 'udp', :dport => '2049', :jump => 'ACCEPT'},
]
