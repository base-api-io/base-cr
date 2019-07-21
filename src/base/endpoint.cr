module Base
  # The base class for an endpoint.
  #
  # It handles request lifecycle and error handling and offers a Crest::Resource.
  class Endpoint
    getter resource : Crest::Resource
    getter path : String = ""

    # Initializes the endpoint with an access_token and url.
    def initialize(access_token : String, url : String)
      @resource =
        Crest::Resource.new(
          "#{url}/v1/#{path}/",
          headers: {"Authorization" => "Bearer #{access_token}"})
    end

    # Handles errors that happen in its block.
    def request
      yield
    rescue error : Crest::UnprocessableEntity # 422
      raise InvalidRequest.new(InvalidRequest::Data.from_json(error.response.body))
    rescue Crest::Unauthorized # 401
      raise Unauthorized.new
    rescue error : Exception
      raise UnkownError.new(error)
    end
  end
end
