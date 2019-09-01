module Base
  # The model for a mailing list
  struct MailingList
    include JSON::Serializable

    @[JSON::Field(converter: Base::TimeConverter)]
    getter created_at : Time

    getter unsubscribe_redirect_url : String
    getter emails : Array(String)
    getter name : String
    getter id : String
  end
end
