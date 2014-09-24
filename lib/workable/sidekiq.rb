require File.expand_path('../sidekiq/middleware', __FILE__)
require File.expand_path('../sidekiq/handler', __FILE__)

module Workable::Sidekiq
  class << self
    def notify(exception, context)
      Workable::Sidekiq::Handler.error(exception, context)
    end
  end
end