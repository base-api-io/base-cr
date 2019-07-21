module Base
  # Struct for the user.
  struct User
    include JSON::Serializable

    @[JSON::Field(converter: Base::TimeConverter)]
    getter created_at : Time

    getter email : String
    getter id : String
  end
end
