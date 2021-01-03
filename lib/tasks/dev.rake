# frozen_string_literal: true

namespace :creds do
  task :dev do
    sh 'EDITOR=vi rails credentials:edit -e development'
  end

  task :prod do
    sh 'EDITOR=vi rails credentials:edit -e production'
  end
end
