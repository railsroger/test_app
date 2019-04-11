server '84.246.210.154', user: 'deploy', roles: %w[app db web]

set :stage, :es
set :rails_env, :production
set :branch, 'prod/es'
set :nginx_server_name, '84.246.210.154'

set :ssh_options, port: 2525
