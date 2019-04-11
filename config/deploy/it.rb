server '157.230.108.194', user: 'deploy', roles: %w[app db web]

set :stage, :it
set :rails_env, :production
set :branch, 'prod/it'
set :nginx_server_name, '157.230.108.194'

set :ssh_options, port: 2525
