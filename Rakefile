class App
  ATOM = "~/Application/Atom"
end

namespace :setup do
  namespace :atom do
    directory App::ATOM
    
    file App::ATOM do
      sh "brew cask install Atom --appdir ~/Applications"
    end

    task install: App::ATOM do
      sh "apm install --production --packages-file ~/.dotfiles/atom/packages.txt"
    end
  end
end
