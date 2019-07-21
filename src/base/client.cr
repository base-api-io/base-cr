require "./endpoint"
require "./models/**"
require "./endpoints/**"

module Base
  # A client containing all the endpoints.
  class Client
    # Endpoint for the sessions.
    getter sessions : Endpoints::Sessions

    # Endpoint for the emails.
    getter emails : Endpoints::Emails

    # Endpoint for the images.
    getter images : Endpoints::Images

    # Endpoint for the users.
    getter users : Endpoints::Users

    # Endpoint for the files.
    getter files : Endpoints::Files

    # Initializes a new client with an access_token and optional url.
    def initialize(access_token : String, url : String = "http://localhost:8080")
      @users =
        Endpoints::Users.new(
          access_token: access_token,
          url: url)

      @files =
        Endpoints::Files.new(
          access_token: access_token,
          url: url)

      @images =
        Endpoints::Images.new(
          access_token: access_token,
          url: url)

      @sessions =
        Endpoints::Sessions.new(
          access_token: access_token,
          url: url)

      @emails =
        Endpoints::Emails.new(
          access_token: access_token,
          url: url)
    end
  end
end
