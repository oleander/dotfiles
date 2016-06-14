lock "3.5.0"

role :server,  %w{localhost ocean atlantic}
set :application, "dotfiles"
set :repo_url, "git@github.com:oleander/dotfiles.git"
set :deploy_to, "~/.dotfiles"
set :keep_releases, 5
set :pty, true
set :configs, ["gemrc", "gitignore", "gvimrc", "irbrc", "tmuxrc", "vimrc", "zshrc", "gitconfig", "hushlogin"]
set :scm, :git
set :git_strategy, Capistrano::Git::SubmoduleStrategy
set :git_keep_meta, true
set :log_level, :info
set :format , :pretty

namespace :deploy do
  task :symlink do
    on roles(:server) do
      fetch(:configs).each do |config|
        execute "ln", "-fs", File.join(release_path, config), "~/.#{config}"
      end
    end
  end

  after :updated, :symlink
end