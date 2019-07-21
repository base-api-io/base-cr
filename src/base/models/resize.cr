module Base
  # Struct for the resize data.
  struct Resize
    getter height : Int32
    getter width : Int32

    def initialize(@width, @height)
    end

    def to_s
      [@width, @height].join("_")
    end
  end
end
