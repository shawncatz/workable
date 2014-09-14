class Workable::Base
  include Sidekiq::Worker
  sidekiq_options retry: false, backtrace: true

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

  def flash(title, message, options={})
    o = {faye: true, plex: false}.merge(options)
    Services::Faye.flash(title, message) if o[:faye]
    Services::Plex.info(title, message) if o[:plex]
    logger.info "flash: #{title} - #{message}"
  end

  def info(msg, options={})
    o = {faye: false, plex: false}.merge(options)
    Services::Faye.info(self.class.name, msg, o[:faye])
    Services::Plex.info(self.class.name, msg) if o[:plex]
    logger.info("#{self.class.name} #{msg}")
  end

  def warn(msg, options={})
    o = {faye: false, plex: false}.merge(options)
    Services::Faye.warn(self.class.name, msg, o[:faye])
    Services::Plex.warn(self.class.name, msg) if o[:plex]
    logger.warn("#{self.class.name} #{msg}")
  end

  def error(msg, options={})
    o = {faye: false, plex: false}.merge(options)
    Services::Faye.error(self.class.name, msg, o[:faye])
    Services::Plex.error(self.class.name, msg) if o[:plex]
    logger.error("#{self.class.name} #{msg}")
  end

  def error!(e)
    error e.message
    raise e
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
