module Base
  # This endpoint contains methods for creating and managing users.
  module Endpoints
    class Users < Endpoint
      @path = "users"

      # Creates a user with the given credentials.
      def create(email : String, password : String, confirmation : String) : User
        request do
          response =
            @resource.post("", form: {
              "confirmation" => confirmation,
              "password"     => password,
              "email"        => email,
            })

          User.from_json(response.body)
        end
      end

      # Gets the details of the user with the given ID.
      def get(id : String) : User
        request do
          response =
            @resource.get id

          User.from_json(response.body)
        end
      end

      # Deletes the user with the given ID.
      def delete(id : String) : User
        request do
          response =
            @resource.delete id

          User.from_json(response.body)
        end
      end
    end
  end
end
