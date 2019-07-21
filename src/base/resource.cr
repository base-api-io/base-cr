module Base
  class Unauthorized < Exception
  end

  class UnkownError < Exception
    getter error : Crest::RequestFailed

    def initialize(@error)
    end
  end

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

  class Resource
    getter path : String = ""

    @resource : Crest::Resource

    def initialize(access_token : String, endpoint : String)
      @resource =
        Crest::Resource.new(
          "#{endpoint}/v1/#{path}/",
          headers: {"Authorization" => "Bearer #{access_token}"})
    end

    def request
      yield
    rescue error : Crest::UnprocessableEntity # 422
      raise InvalidRequest.new(InvalidRequest::Data.from_json(error.response.body))
    rescue Crest::Unauthorized # 401
      raise Unauthorized.new
    rescue error : Crest::RequestFailed
      raise UnkownError.new(error)
    end
  end
end
