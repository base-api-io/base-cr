module Base
  # Struct for the from.
  struct Form
    include JSON::Serializable

    @[JSON::Field(converter: Base::TimeConverter)]
    getter created_at : Time

    getter name : String
    getter id : String
  end
end
