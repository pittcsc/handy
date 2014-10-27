server 'app-01', roles: %w{app web db}, user: 'handy'

set :ssh_options,
  proxy: Net::SSH::Proxy::Command.new('ssh gateway.do-nyc3.pittcsc.org -q -W %h:%p'),
  forward_agent: true
