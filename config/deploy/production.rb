role :app, %w{app-01}
role :web, %w{app-01}
role :db,  %w{app-01}

set :ssh_options,
  proxy: Net::SSH::Proxy::Command.new('ssh gateway.do-nyc3.pittcsc.org -q -W %h:%p'),
  forward_agent: true
