
set :application, "api.putin"
set :deploy_to,   "/www/api.putin.io"
set :user,        "root"
set :scm,         :git
set :repo_url, 'git@github.com:nike-17/grape-voter.git'

server 'putin.io', user: 'root', roles: %w{web app}

set :linked_dirs, %w{bin vendor/bundle shared/log shared/pids shared/sockets }

# how many old releases do we want to keep, not much
set :keep_releases, 5