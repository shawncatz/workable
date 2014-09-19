class Workable::Base
  include Sidekiq::Worker
  sidekiq_options retry: false, backtrace: true

  def logger
    @logger ||= Logger.new STDOUT
  end

  protected

  def synchronize(key)
    unless lock(key)
      warn "locked: #{key}: #{locked?(key)}"
      return
    end

    begin
      yield
    rescue Workers::Base::Debug => e
      info e.message
    rescue Workers::Base::Info => e
      info e.message
    rescue Workers::Base::Warning => e
      warn e.message
    rescue Workers::Base::Error => e
      error e.message
    rescue Workers::Base::Fatal => e
      error! e
    rescue => e
      error! e
    ensure
      unlock(key)
    end
  end

  private

  def lock(key)
    return false if locked?(key)
    Rails.cache.write(key, Time.now)
    true
  end

  def locked?(key)
    Rails.cache.read(key)
  end

  def unlock(key)
    Rails.cache.delete(key)
  end

  class Workable::Base::Debug < StandardError
  end
  class Workable::Base::Info < StandardError
  end
  class Workable::Base::Warning < StandardError
  end
  class Workable::Base::Error < StandardError
  end
  class Workable::Base::Fatal < StandardError
  end
end
