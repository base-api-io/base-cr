module Base
  # The model for a paginated list
  struct List(T)
    # The model for the metadata
    struct Metadata
      include JSON::Serializable

      getter count : Int32
    end

    include JSON::Serializable

    getter metadata : Metadata
    getter items : Array(T)
  end
end
