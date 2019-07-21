module Base
  class UserResource < Resource
    @path = "users"

    def create(email : String, password : String, confirmation : String) : User
      request do
        response =
          @resource.post(form: {
            "confirmation" => confirmation,
            "password"     => password,
            "email"        => email,
          })

        User.from_json(response.body)
      end
    end

    def get(id) : User
      request do
        response =
          @resource.get id

        User.from_json(response.body)
      end
    end

    def delete(id) : User
      request do
        response =
          @resource.delete id

        User.from_json(response.body)
      end
    end
  end
end
