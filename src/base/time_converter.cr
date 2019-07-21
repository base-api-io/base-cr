module Base
  # A JSON converter for RFC2822 time format.
  module TimeConverter
    extend self

    def from_json(parser)
      Time::Format::RFC_2822.parse(parser.read_string)
    end

    def to_json(value, builder)
      value.to_rfc2822
    end
  end
end
