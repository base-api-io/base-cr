module Base
  # This endpoint contains a method for authenticating a user.
  module Endpoints
    class Sessions < Endpoint
      @path = "sessions"

      # Tries to authenticate (log in) the user with email and password.
      #
      # For security reasons if the email address is not registered or the
      # password is incorrect, "INVALID_CREDENTIALS" error will be returned.
      def authenticate(email : String, password : String) : User
        request do
          response =
            @resource.post(form: {
              "password" => password,
              "email"    => email,
            })

          User.from_json(response.body)
        end
      end
    end
  end
end
