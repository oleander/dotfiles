require 'rubygems/user_interaction'
include Gem::UserInteraction

namespace :overcommit do
  task :symlink do
    src = File.join(__dir__, "../configs/overcommit.yml")
    config = ".overcommit.yml"

    if File.exists?(src)
      abort unless ask_yes_no("Override existing #{config}?", false)
    end

    FileUtils.symlink(src, config, force: true, verbose: true)
  end

  task install: [:symlink] do
    system "overcommit --install"
  end

  task :test do
    system "overcommit --run"
  end
end
