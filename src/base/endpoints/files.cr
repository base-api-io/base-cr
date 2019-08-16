module Base
  module Endpoints
    # This endpoint contains methods for uploading and managing files.
    class Files < Endpoint
      @path = "files"

      # Uploads the given file and returns its metadata.
      def create(file : ::File) : File
        request do
          response =
            @resource.post(form: {"file" => file})

          File.from_json(response.body)
        end
      end

      # Returns the publicly accessible download URL of the file with the
      # given ID.
      def download_url(id : String) : String
        "#{@resource.url}#{id}/download"
      end

      # Downloads the file with the given ID into an IO.
      def download(id : String) : IO
        request do
          response =
            Crest.get "#{id}/download"

          response.http_client_res.body_io? ||
            IO::Memory.new(response.body)
        end
      end

      # Returns the metadata of the file with the given ID.
      def get(id : String) : File
        request do
          response =
            @resource.get id

          File.from_json(response.body)
        end
      end

      # Deletes the file with the given ID.
      def delete(id : String) : File
        request do
          response =
            @resource.delete id

          File.from_json(response.body)
        end
      end
    end
  end
end
