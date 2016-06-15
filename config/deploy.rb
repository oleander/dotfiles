lock "3.5.0"

role :server,  %w{ocean atlantic}
set :application, "dotfiles"
set :repo_url, "git@github.com:oleander/dotfiles.git"
set :deploy_to, "~/.dotfiles"
set :keep_releases, 5
set :pty, true
set :configs, `ls symlinks`.split(/\s+/)
set :scm, :git
set :git_strategy, Capistrano::Git::SubmoduleStrategy
set :git_keep_meta, true
set :log_level, :info
set :format , :pretty

namespace :deploy do
  task :symlink do
    on roles(:server) do
      fetch(:configs).each do |config|
        execute "ln", "-fs", File.join(release_path, "symlinks", config), "~/.#{config}"
      end
    end
  end

  task :local do
    fetch(:configs).each do |config|
      sh "ln", "-fs", File.join(Dir.pwd, "symlinks", config), "/Users/linus/.#{config}"
    end
  end
  
  after :updated, :symlink
  after :updated, :local
end