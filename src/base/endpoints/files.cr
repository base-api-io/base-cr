module Base
  module Endpoints
    # This endpoint contains methods for uploading and managing files.
    class Files < Endpoint
      @path = "files"

      # Lists the files of a project
      def list(page : Int32 = 1, per_page : Int32 = 10) : List(File)
        request do
          response =
            @resource.get(form: {
              "per_page" => per_page,
              "page"     => page,
            })

          List(File).from_json(response.body)
        end
      end

      # Uploads the given file and returns its metadata.
      def create(file : ::File) : File
        request do
          response =
            @resource.post("", form: {"file" => file})

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
            Crest.get download_url(id)

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
