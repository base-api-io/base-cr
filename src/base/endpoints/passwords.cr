module Base
  module Endpoints
    # This endpoint contains methods for handling the forgot password flow.
    class Passwords < Endpoint
      @path = "password"

      # Generates a forgot password token for the user with the given email.
      def forgot_password(email : String) : ForgotPasswordToken
        request do
          response =
            @resource.post(form: {
              "email" => email,
            })

          ForgotPasswordToken.from_json(response.body)
        end
      end

      # Sets the password of a user with the given forgot password token.
      def set_password(forgot_password_token : String,
                       confirmation : String,
                       password : String) : User
        request do
          response =
            @resource.put(form: {
              "forgot_password_token" => forgot_password_token,
              "confirmation"          => confirmation,
              "password"              => password,
            })

          User.from_json(response.body)
        end
      end
    end
  end
end
