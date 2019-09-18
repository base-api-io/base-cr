module Base
  # Struct for the from submission.
  struct FormSubmission
    include JSON::Serializable

    @[JSON::Field(converter: Base::TimeConverter)]
    getter created_at : Time

    getter files : Array(String)
    getter fields : JSON::Any
    getter id : String
  end
end
