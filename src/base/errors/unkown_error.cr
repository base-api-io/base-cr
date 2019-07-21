module Base
  # An error when we don't know what happened.
  class UnkownError < Exception
    getter error : Crest::RequestFailed

    def initialize(@error)
    end
  end
end
