module Base
  module Endpoints
    # This endpoint contains methods for creating and managing users.
    class Users < Endpoint
      @path = "users"

      # Lists the users of a project
      def list(page : Int32 = 1, per_page : Int32 = 10) : List(User)
        request do
          response =
            @resource.get("", params: {
              "per_page" => per_page,
              "page"     => page,
            })

          List(User).from_json(response.body)
        end
      end

      # Creates a user with the given credentials.
      def create(email : String,
                 password : String,
                 confirmation : String,
                 custom_data : T) : User forall T
        request do
          response =
            @resource.post("", form: {
              "custom_data"  => custom_data.to_json,
              "confirmation" => confirmation,
              "password"     => password,
              "email"        => email,
            })

          User.from_json(response.body)
        end
      end

      # Updates a user with the given data.
      def update(id : String, email : String, custom_data : T) : User forall T
        request do
          response =
            @resource.post(id, form: {
              "custom_data" => custom_data.to_json,
              "email"       => email,
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
