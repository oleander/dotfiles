require "tmpdir"
require "pathname"
require "rake/clean"

root_path       = Pathname.new("/tmp/eq")
mirror_path     = root_path.join("mirror.git")
bare_path       = root_path.join("bare.git")
optimized_path  = root_path.join("optimized")
bundle_path     = root_path.join("bundles")
original_path   = root_path.join("original")
bfg_bin_path    = Pathname.new("/usr/local/bin/bfg")

original_bundle_path = bundle_path.join("original.bundle")
optimized_bundle_path = bundle_path.join("optimized.bundle")

CLEAN.include optimized_path
CLEAN.include bare_path
CLEAN.include bundle_path
CLEAN.include original_path

ENV["OVERCOMMIT_DISABLE"] = "1"
ENV["FILTER_BRANCH_SQUELCH_WARNING"] = "1"

namespace :eq do
  directory root_path
  directory bundle_path

  desc "Compares the bundle size before vs after optimization"
  task check: [:clean, :bundles] do
    sh "du -sh #{original_bundle_path}"
    sh "du -sh #{optimized_bundle_path}"
  end

  task bundles: [original_bundle_path, optimized_bundle_path]

  file original_bundle_path => [bundle_path, original_path] do
    chdir(original_path) do
      sh "git bundle create #{original_bundle_path} --all"
    end
  end

  file optimized_bundle_path => [bundle_path, optimized_path] do
    chdir(optimized_path) do
      sh "git bundle create #{optimized_bundle_path} --all"
    end
  end

  file optimized_path => [bare_path] do
    sh "git clone #{bare_path} #{optimized_path}"

    chdir(optimized_path) do
      sh "git reflog expire --expire=now --all"
      sh "git gc --prune=now --aggressive"
    end
  end

  file bare_path => [mirror_path] do
    sh "git clone --bare #{mirror_path} #{bare_path}"
    sh "git --git-dir #{bare_path} filter-branch --tree-filter 'rm -rf public/assets' HEAD"
    sh %{bfg --strip-blobs-bigger-than 10M --strip-biggest-blobs 5 --no-blob-protection #{bare_path}}
    sh %{bfg --convert-to-git-lfs "*.{png,mp4,jpg,gif,pdf,ogg,dat,mmdb,xml,JPG,svg,eot}" --no-blob-protection  #{bare_path}}
  end

  file mirror_path => [root_path] do
    sh "git clone --mirror git@github.com:philippk/equippostore.git #{mirror_path}"
  end

  file original_path => [mirror_path] do
    sh "git clone #{mirror_path} #{original_path}"
  end

  task setup: [:check] do
    chdir(optimized_path) do
      sh "rbenv global 2.5.0"
      sh "bundle install"
      sh "git lfs pull"
      sh "atom ."
    end
  end
end
