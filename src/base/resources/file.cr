module Base
  class FileResource < Resource
    @path = "files"

    def create(file : ::File)
      request do
        response =
          @resource.post(form: {"file" => file})

        File.from_json(response.body)
      end
    end

    def download_url(id : String) : String
      "#{@resource.url}#{id}/download"
    end

    def download(id) : NamedTuple(filename: String, file: ::File)
      request do
        response =
          @resource.get "#{id}/download"

        filename =
          response
            .headers["Content-Disposition"]
            .to_s
            .split(";")
            .map(&.strip)
            .find(&.starts_with?("filename"))
            .to_s
            .split("=")
            .last?.try(&.[1..-2])
            .to_s

        body_io =
          response.http_client_res.body_io? || IO::Memory.new(response.body)

        {
          file:     ::File.tempfile { |io| IO.copy(body_io, io) },
          filename: filename,
        }
      end
    end

    def get(id) : File
      request do
        response =
          @resource.get id

        File.from_json(response.body)
      end
    end

    def delete(id) : File
      request do
        response =
          @resource.delete id

        File.from_json(response.body)
      end
    end
  end
end
