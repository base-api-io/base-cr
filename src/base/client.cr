require "./endpoint"
require "./models/**"
require "./endpoints/**"

module Base
  # A client containing all the endpoints.
  class Client
    # Endpoint for the mailing lists
    getter mailing_lists : Endpoints::MailingLists

    # Endpoint for the forgot password flow.
    getter passwords : Endpoints::Passwords

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

    # Endpoint for the forms.
    getter forms : Endpoints::Forms

    # Initializes a new client with an access_token and optional url.
    def initialize(access_token : String, url : String = "https://api.base-api.io")
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

      @passwords =
        Endpoints::Passwords.new(
          access_token: access_token,
          url: url)

      @mailing_lists =
        Endpoints::MailingLists.new(
          access_token: access_token,
          url: url)

      @forms =
        Endpoints::Forms.new(
          access_token: access_token,
          url: url)
    end
  end
end
