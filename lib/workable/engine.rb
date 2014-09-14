module Workable
  class Engine < ::Rails::Engine
    isolate_namespace Workable
    config.autoload_paths << File.expand_path("../lib", __FILE__)
    config.autoload_paths << File.expand_path("../app/workable", __FILE__)
    config.autoload_paths << File.expand_path("app/workable", __FILE__)
  end
end
