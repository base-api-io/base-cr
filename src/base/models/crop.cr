module Base
  # Struct for the crop data.
  struct Crop
    getter height : Int32
    getter width : Int32
    getter left : Int32
    getter top : Int32

    def initialize(@width, @height, @left, @top)
    end

    def to_s
      [@width, @height, @left, @top].join("_")
    end
  end
end
