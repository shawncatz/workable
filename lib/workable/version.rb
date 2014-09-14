module Workable
  module Version
    MAJOR = 0
    MINOR = 1
    TINY  = 0
    TAG   = nil
    LIST = [MAJOR, MINOR, TINY, TAG].compact
    STRING = LIST.join('.')
  end
end