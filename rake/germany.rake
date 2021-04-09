require "open3"

# MAIN = "KDB-1101/define-rb".freeze
# BRANCHES = [MAIN] + %w{KDB-1203/gems/endpoint KDB-1208/gems/tree KDB-1202/gems/container KDB-1207/gems/setting KDB-1201/gems/collapse KDB-1204/gems/pipeable KDB-1206/gems/schema}.freeze
#
# MAIN = "KDB-1101/define-rb".freeze
MAIN = "KDB-1101/define-rb"
BRANCHES = %w{KDB-1208/gems/tree KDB-1203/gems/endpoint KDB-1202/gems/container KDB-1207/gems/setting KDB-1201/gems/collapse KDB-1204/gems/pipeable KDB-1206/gems/schema KDB-1205/gems/remap}.freeze + [MAIN]

class Actions
  def self.call
    new.run
  end

  def initialize
    @threads = []
  end

  def run
    rspec
    rubocop
    examples
    @threads.each(&:join)
  end

  private

  def root_path
    Pathname(Dir.pwd)
  end

  def gems_path
    root_path.join("gems/define-rb/gems")
  end

  def rspec
    sh "bundle", "exec", "rspec", "--format", "progress", gems_path
  end

  def rubocop
    sh "bundle", "exec", "rubocop", gems_path
  end

  def sh(*args)
    thread { system *args.map(&:to_s) }
  end

  def examples
    gems_path.glob("**/examples/*.rb").map do |path|
      sh "bundle", "exec", "ruby", path.to_path
    end
  end

  def thread(&block)
    @threads << Thread.new(&block)
  end
end

def branches(&block)
  cd Dir.pwd do
    BRANCHES.each do |branch|
      puts ["\nBranch", branch].join(" ")
      sh "git", "checkout", branch
      block.call(branch)
    end

    sh "git", "checkout", MAIN
  end
end

namespace :src do
  task :actions do
    branches do
      Actions.call
    end
  end

  task :push do
    branches do |branch|
      sh "git", "push", "origin", branch
    end
  end

  namespace :merge do
    task :master do
      cd Dir.pwd do
        sh "git", "checkout", "master"
        sh "git", "pull", "origin", "master"
        sh "git", "checkout", MAIN
        sh "git", "merge", "--no-edit", "master"
      end
    end

    task :recursively do
      cd Dir.pwd do
        BRANCHES.permutation(2).to_a.each do |master, slave|
          puts ["\nMerge", master, "with", slave].join(" ")
          sh "git", "checkout", master
          sh "git", "merge", "--no-edit", slave
        end

        sh "git", "checkout", MAIN
      end
    end
  end

  task sync: %i[merge:master merge:recursively actions]
end
