server 'app-01', roles: %w(app web db), user: 'handy'

set :ssh_options, forward_agent: true
