server '95.213.247.139', user: 'deploy', roles: %w[app db web]

set :stage, :staging
set :rails_env, :production
set :branch, 'develop'
set :nginx_server_name, 'hisense.m2hdev.com'

set :ssh_options, port: 2525
