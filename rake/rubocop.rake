task rubocop: %w[rubocop:gems rubocop:test] do
  puts "Installed!"
end

namespace :rubocop do
  file ".rubocop.yml" do
    safe_ln "/Users/loleander/.dotfiles/configs/rubocop.yml", Pathname(Dir.pwd).join(".rubocop.yml")
  end

  task :gems do
    sh 'gem', 'install', 'rubocop', 'rubocop-rspec', 'rubocop-rake'
  end

  task test: ".rubocop.yml" do
    sh 'rubocop', '--fail-level', 'F', '--lint'
  end
end
