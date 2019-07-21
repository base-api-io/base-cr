module Base
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

  struct Resize
    getter height : Int32
    getter width : Int32

    def initialize(@width, @height)
    end

    def to_s
      [@width, @height].join("_")
    end
  end

  class ImageResource < Resource
    @path = "images"

    def create(image : ::File)
      request do
        response =
          @resource.post(form: {"image" => image})

        Image.from_json(response.body)
      end
    end

    def image_url(id : String,
                  quality : Int32 | Nil = nil,
                  resize : Resize | Nil = nil,
                  format : String | Nil = nil,
                  crop : Crop | Nil = nil)
      quality_param =
        quality.try { |data| [data.to_s] } || [] of String

      resize_param =
        resize.try { |data| [data.to_s] } || [] of String

      format_param =
        format.try { |data| [data] } || [] of String

      crop_param =
        crop.try { |data| [data.to_s] } || [] of String

      params =
        HTTP::Params.new({
          "quality" => quality_param,
          "format"  => format_param,
          "resize"  => resize_param,
          "crop"    => crop_param,
        })

      "#{@resource.url}#{id}/version?#{params}"
    end

    def get(id) : Image
      request do
        response =
          @resource.get id

        Image.from_json(response.body)
      end
    end

    def delete(id) : Image
      request do
        response =
          @resource.delete id

        Image.from_json(response.body)
      end
    end
  end
end
