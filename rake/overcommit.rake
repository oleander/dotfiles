namespace :overcommit do
  task :symlink do
    FileUtils.symlink(File.join(__dir__, "../configs/overcommit.yml"), ".overcommit.yml", force: true, verbose: true)
  end

  task install: [:symlink] do
    system "overcommit --install"
  end

  task :test do
    system "overcommit --run"
  end
end
