module Base
  # Struct for the email.
  struct Email
    include JSON::Serializable

    @[JSON::Field(converter: Base::TimeConverter)]
    getter created_at : Time

    getter from_address : String
    getter to_address : String
    getter subject : String
    getter html : String
    getter text : String
    getter id : Int32
  end
end
