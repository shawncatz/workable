module Workable
  class Engine < ::Rails::Engine
    isolate_namespace Workable
    config.autoload_paths << File.expand_path("../lib", __FILE__)
    config.autoload_paths << File.expand_path("../app/workable", __FILE__)
    config.autoload_paths << File.expand_path("app/workable", __FILE__)

    initializer 'workable_sidekiq' do
      require 'sidekiq'
      require 'sidekiq/scheduler'
      require 'sidekiq/failures'
    end
  end
end
