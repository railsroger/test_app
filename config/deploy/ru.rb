server '185.159.131.78', user: 'deploy', roles: %w[app db web]

set :stage, :ru
set :rails_env, :production
set :branch, 'prod/ru'
set :nginx_server_name, '185.159.131.78'

set :ssh_options, port: 2525
