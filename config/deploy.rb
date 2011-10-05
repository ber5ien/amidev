set :application, "amidev"
set :scm, :git
set :git_enable_submodules, 1
set :repository, "git@github.com:ber5ien/amidev.git"
set :branch, "master"
set :ssh_options, { :forward_agent => true }
set :stage, :production
set :user, "root"
set :use_sudo, false
set :runner, "deploy"
set :deploy_to, "/u/apps/#{stage}/#{application}"
set :app_server, :passenger
set :domain, "amidev.co.uk"
#========================
#ROLES
#========================
role :app, domain
role :web, domain
role :db, domain, :primary => true
#========================
#CUSTOM
#========================
namespace :deploy do
  task :start, :roles => :app do
  run "touch #{current_release}/tmp/restart.txt"
end
task :stop, :roles => :app do
  # Do nothing.
end
desc "Restart Application"
task :restart, :roles => :app do
run "touch #{current_release}/tmp/restart.txt"
end
end
