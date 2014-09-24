require 'active_support/all'
class Workable::Sidekiq::Middleware
  def initialize(options=nil)
    @options = options
  end
  def call(worker, message, queue)
    message['args'][0] = message['args'][0].stringify_keys
    puts "WORKABLE:#{message['args'].inspect}"
    yield
  end
end