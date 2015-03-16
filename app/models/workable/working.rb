module Workable::Working
  extend ActiveSupport::Concern

  included do
    def enqueue(action, options={})
      options.merge!({id: self.id.to_s})
      klass = prepare(action, options)
      klass.perform_async(options)
    end

    def enqueue_in(seconds, action, options={})
      options.merge!({id: self.id.to_s})
      klass = prepare(action, options)
      klass.perform_in(seconds, options)
    end

    def prepare(action, options={})
      name = "Workers::#{self.class.name.capitalize}::#{action.capitalize}"
      name.constantize
    rescue => e
      raise "could not find worker: #{name}", e.message
    end
  end
end
