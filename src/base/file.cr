require "./resource"

module Base
  struct File
    include JSON::Serializable

    @[JSON::Field(converter: Base::TimeConverter)]
    getter created_at : Time

    getter extension : String
    getter name : String
    getter size : Int64
    getter id : String
  end
end
