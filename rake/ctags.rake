require 'rubygems/user_interaction'
include Gem::UserInteraction
require 'open3'

namespace :ctags do
  task rebuild: :clear do
    IO.popen(["git", "ls-files"], "w").write(IO.popen(["ctags", "-R","--fields=+KSn", "--languages=ruby", "--links=no", "-L"]).read)
  end

  task :clear do
    rm_rf "tags"
  end
end
