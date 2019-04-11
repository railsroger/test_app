server '165.227.153.68', user: 'deploy', roles: %w[app db web]

set :stage, :it
set :rails_env, :production
set :branch, 'prod/fr'
set :nginx_server_name, '165.227.153.68'

set :ssh_options, port: 2525
