require "bundler/capistrano"
local_user = ENV['USER'] || ENV['USERNAME']
ssh_options[:forward_agent] = true
default_run_options[:pty] = true
set :default_environment, { 'PATH' => '$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH' }
set :user, 'root'
set :application, "elif"
set :use_sudo, false
set :scm, :git
set :repository, 'git@bitbucket.org/bismailov/karvonsaroy.git'
set :keep_releases, 5
set :rails_env, "production" #added for delayed job

if ENV['DEPLOY'] == 'PRODUCTION'
  puts "*********************************************************************************************"
  puts "*            Deploying to the PRODUCTION server!                                            *"
  puts "*********************************************************************************************"
  set :deploy_to, "/data/elif"
  set :branch, 'master' # или любая другая ветка
  set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
else
  puts "*********************************************************************************************"
  puts "*            Deploying to the DEV server!                                                   *"
  puts "*********************************************************************************************"
  set :deploy_to, "/data/elif"
  set :branch, 'master' # или любая другая ветка
  set :unicorn_conf, "#{deploy_to}/current/config/devunicorn.rb"
end
role :web, "185.8.212.31"
role :app, "185.8.212.31"
role :db,  "185.8.212.31", :primary => true

set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

after "deploy:restart",     "deploy:cleanup"
after "deploy:setup",       "after_setup"

task :after_setup do
  run "touch #{deploy_to}/shared/log/production.log"
  # run "mkdir #{deploy_to}/shared/upload"
end

after 'deploy:finalize_update' do
  if ENV['DEPLOY'] == 'PRODUCTION'
    # копируем database.yml
    run "cp -f #{release_path}/config/prod_database.yml #{release_path}/config/database.yml"
  else
    # копируем database.yml
    run "cp -f #{release_path}/config/beta_database.yml #{release_path}/config/database.yml"
  end
end

after 'deploy:update_code' do
  # удаляем лог
  run "rm -rf #{current_release}/log"
  # Ссылка на лог
  run "cd #{current_release} && ln -s #{deploy_to}/#{shared_dir}/log log"
  # Миграция
  run "cd #{current_release}; export RAILS_ENV=production; rake db:migrate"
  # Ссылка на uploads
  # run "rm -rf #{current_release}/public/upload"
  # run "cd #{current_release}/public && ln -s #{deploy_to}/shared/upload upload"
end

namespace :deploy do
  task :restart do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end

  task :start do
    run "cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D"
  end

  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end
end
