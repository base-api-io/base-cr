module Base
  # Struct for the user.
  struct User
    include JSON::Serializable

    @[JSON::Field(converter: Base::TimeConverter)]
    getter created_at : Time

    getter custom_data : JSON::Any
    getter email : String
    getter id : String
  end
end
