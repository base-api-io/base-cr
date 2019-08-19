module Base
  module Endpoints
    # This endpoint contains methods for uploading and managing images.
    class Images < Endpoint
      @path = "images"

      # Uploads the given image and returns its metadata.
      #
      # Only images with ImageMagick understands can be uploaded otherwise it
      # will raise an error.
      def create(image : ::File) : Image
        request do
          response =
            @resource.post("", form: {"image" => image})

          Image.from_json(response.body)
        end
      end

      # Returns the image url of the image with the given ID.
      #
      # It is possible to crop and resize the image and change its format
      # and quality.
      def image_url(id : String,
                    quality : Int32 | Nil = nil,
                    resize : Resize | Nil = nil,
                    format : String | Nil = nil,
                    crop : Crop | Nil = nil)
        quality_param =
          quality.try { |data| [data.to_s] } || [] of String

        resize_param =
          resize.try { |data| [data.to_s] } || [] of String

        crop_param =
          crop.try { |data| [data.to_s] } || [] of String

        format_param =
          format.try { |data| [data] } || [] of String

        params =
          HTTP::Params.new({
            "quality" => quality_param,
            "format"  => format_param,
            "resize"  => resize_param,
            "crop"    => crop_param,
          })

        "#{@resource.url}#{id}/version?#{params}"
      end

      # Downloads the image with the given ID.
      #
      # It is possible to crop and resize the image and change its format
      # and quality.
      def download(id : String,
                   quality : Int32 | Nil = nil,
                   resize : Resize | Nil = nil,
                   format : String | Nil = nil,
                   crop : Crop | Nil = nil)
        request do
          response =
            Crest.get image_url(id, quality, resize, format, crop)

          response.http_client_res.body_io? ||
            IO::Memory.new(response.body)
        end
      end

      # Returns the metadata of the image with the given ID.
      def get(id) : Image
        request do
          response =
            @resource.get id

          Image.from_json(response.body)
        end
      end

      # Deletes the image with the given ID.
      def delete(id) : Image
        request do
          response =
            @resource.delete id

          Image.from_json(response.body)
        end
      end
    end
  end
end
