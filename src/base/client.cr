require "./user"
require "./resources/**"

module Base
  class Client
    getter images : ImageResource
    getter users : UserResource
    getter files : FileResource

    def initialize(access_token : String, endpoint : String = "http://localhost:8080")
      @users =
        UserResource.new(
          access_token: access_token,
          endpoint: endpoint)

      @files =
        FileResource.new(
          access_token: access_token,
          endpoint: endpoint)

      @images =
        ImageResource.new(
          access_token: access_token,
          endpoint: endpoint)
    end
  end
end
