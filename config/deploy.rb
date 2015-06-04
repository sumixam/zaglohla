set :application, 'zaglohla'
set :repo_url, 'git@github.com:Kirkkonen/zaglohla.git'

set :ssh_options, { :forward_agent => true }

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/home/zaglohla/www'
set :scm, :git
set :rvm_type, :user
set :rvm_ruby_version, '2.0.0-p353@zaglohla'
set :rails_env, 'production'

set :format, :pretty
set :log_level, :debug
set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, fetch(:linked_dirs, []).push(%w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/ckeditor_assets})
linked_dirs = Set.new(fetch(:linked_dirs, [])) # https://github.com/capistrano/rails/issues/52
linked_dirs.merge(%w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/ckeditor_assets})
set :linked_dirs, linked_dirs.to_a

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 20

set :default_env, { rvm_bin_path: '~/.rvm/bin' }
set :bundle_gemfile, -> { release_path.join('Gemfile') }
set :bundle_dir, -> { shared_path.join('bundle') }
set :bundle_flags, '--deployment --quiet'
set :bundle_without, %w{development test}.join(' ')
set :bundle_binstubs, -> { shared_path.join('bin') }
set :bundle_roles, :all
set :bundle_cmd, 'bundle'


set :puma_cmd, "#{fetch(:bundle_cmd, 'bundle')} exec puma"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_conf, "#{shared_path}/config/puma.rb"
set :puma_role, :app

set :honeybadger_async_notify, true

namespace :puma do
  desc 'Start puma'
  task :start do
    on roles (fetch(:puma_role)) do
      within current_path do
        execute :bundle, "exec puma -e production -C #{fetch(:puma_conf)}"
      end
    end
  end

  %w[halt stop restart phased-restart status].each do |command|
    desc "#{command} puma"
    task command do
      on roles (fetch(:puma_role)) do
        within current_path do
          execute :bundle, "exec pumactl -S #{fetch(:puma_state)} #{command}"
        end
      end
    end
  end

end

before 'puma:start', 'rvm:hook'
before 'puma:stop', 'rvm:hook'
before 'puma:restart', 'rvm:hook'

namespace :deploy do
  after :finished, 'puma:stop'
  after :finished, 'puma:start'
end


# before 'deploy:compile_assets', 'deploy:copy_files'

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  task :copy_files do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute :cp,
          release_path.join('config', 'production', 'database.yml'),
          release_path.join('config', 'database.yml')
        execute :cp,
          release_path.join('config', 'production', 'puma.rb'),
          shared_path.join('config', 'puma.rb')
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end

namespace :bundler do
  desc <<-DESC
        Install the current Bundler environment. By default, gems will be \
        installed to the shared/bundle path. Gems in the development and \
        test group will not be installed. The install command is executed \
        with the --deployment and --quiet flags.

        You can override any of these defaults by setting the variables shown below.

          set :bundle_gemfile, -> { release_path.join('Gemfile') }
          set :bundle_dir, -> { shared_path.join('bundle') }
          set :bundle_flags, '--deployment --quiet'
          set :bundle_without, %w{development test}.join(' ')
          set :bundle_binstubs, -> { shared_path.join('bin') }
          set :bundle_roles, :all
    DESC
  task :install do
    on roles fetch(:bundle_roles) do
      within release_path do
        execute :bundle, "--gemfile #{fetch(:bundle_gemfile)}",
          "--path #{fetch(:bundle_dir)}",
          fetch(:bundle_flags),
          "--binstubs #{fetch(:bundle_binstubs)}",
          "--without #{fetch(:bundle_without)}"
      end
    end
  end

  task :map_bins do
    SSHKit.config.command_map.prefix[:rails].push("bundle exec")
    SSHKit.config.command_map.prefix[:rake].push("bundle exec")
  end

  before 'deploy:updated', 'bundler:install'
end

namespace :uploads do
  task :symlink do
    on roles fetch(:bundle_roles) do
      within release_path do
        execute :rm,  "-rf #{release_path}/public/system"
        execute :ln,  "-nfs #{shared_path}/public/system #{release_path}/public/system"
      end
    end
  end
end

namespace :honeybadger do
  task :deploy do
  end
end

after "deploy:updated", "uploads:symlink"
after 'bundler:install', 'deploy:copy_files'

require 'capistrano/sitemap_generator'

# desc 'copy ckeditor nondigest assets'
# task :copy_nondigest_assets do
#   on roles fetch(:bundle_roles) do
#     within release_path do
#       execute :rake, 'ckeditor:create_nondigest_assets'
#     end
#   end
# end
# after 'deploy:assets:precompile', 'copy_nondigest_assets'
