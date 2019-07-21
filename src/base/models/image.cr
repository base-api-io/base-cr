module Base
  # Struct for the image.
  struct Image
    include JSON::Serializable

    @[JSON::Field(converter: Base::TimeConverter)]
    getter created_at : Time

    getter height : Int32
    getter width : Int32
    getter size : Int32

    getter name : String
    getter id : String
  end
end
