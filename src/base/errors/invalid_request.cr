module Base
  # The error for invalid API requests, which are returned from API in the
  # following JSON format:
  #
  #   {
  #     "error": "TYPE_OF_ERROR",
  #     "data": {
  #       "key": "Additional information."
  #     }
  #   }
  class InvalidRequest < Exception
    struct Data
      include JSON::Serializable

      getter data : Hash(String, String | Int32) | Hash(String, String) | Nil
      getter error : String
    end

    getter data : Data

    def initialize(@data : Data)
    end
  end
end
