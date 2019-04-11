server '10.30.2.118', user: 'deploy', roles: %w[app db web]

set :stage, :cn
set :rails_env, :production
set :branch, 'prod/cn'
set :nginx_server_name, '10.30.2.118'

set :ssh_options, port: 2525
