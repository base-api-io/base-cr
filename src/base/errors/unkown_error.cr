module Base
  # An error when we don't know what happened.
  class UnkownError < Exception
    getter error : Exception

    def initialize(@error)
    end
  end
end
