server '160.119.254.89', user: 'deploy', roles: %w[app db web]

set :stage, :sa
set :rails_env, :production
set :branch, 'prod/sa'
set :nginx_server_name, '160.119.254.89'

set :ssh_options, port: 2525
