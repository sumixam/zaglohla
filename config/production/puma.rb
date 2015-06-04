home_path = "/home/zaglohla/www"
environment "production"
threads 2, 16
workers 2
daemonize true
pidfile "#{home_path}/shared/tmp/pids/puma.pid"
bind "unix://#{home_path}/shared/tmp/sockets/puma.sock"
state_path "#{home_path}/shared/tmp/pids/puma.state"
stdout_redirect "#{home_path}/shared/log/log.puma.stdout", "#{home_path}/shared/log/log.puma.stderr", true if respond_to?(:stdout_redirect)
directory "#{home_path}/current"
