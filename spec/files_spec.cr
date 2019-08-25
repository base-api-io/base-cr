require "./spec_helper"

describe Base do
  context "Listing files" do
    it "lists files" do
      WebMock
        .stub(:get, "https://api.base-api.io/v1/files/")
        .to_return(
          body: {
            items: [{
              created_at: Time.now.to_rfc2822,
              extension:  "png",
              name:       "test.png",
              size:       100,
              id:         "id",
            }],
            metadata: {
              count: 1,
            },
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      list =
        client.files.list

      list.should be_a(Base::List(Base::File))
      list.metadata.count.should eq(1)
    end
  end

  context "Create File" do
    it "creates a file" do
      WebMock
        .stub(:post, "https://api.base-api.io/v1/files/")
        .to_return(
          body: {
            created_at: Time.now.to_rfc2822,
            extension:  "png",
            name:       "test.png",
            size:       100,
            id:         "id",
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      file =
        client.files.create(file: File.tempfile)

      file.should be_a(Base::File)
      file.extension.should eq("png")
      file.name.should eq("test.png")
      file.size.should eq(100)
      file.id.should eq("id")
    end
  end

  context "Get File" do
    it "gets a files details" do
      WebMock
        .stub(:get, "https://api.base-api.io/v1/files/file_id")
        .to_return(
          body: {
            created_at: Time.now.to_rfc2822,
            extension:  "png",
            name:       "test.png",
            size:       100,
            id:         "id",
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      file =
        client.files.get("file_id")

      file.should be_a(Base::File)
      file.extension.should eq("png")
      file.name.should eq("test.png")
      file.size.should eq(100)
      file.id.should eq("id")
    end
  end

  context "Downloads File" do
    it "downloads the file" do
      WebMock
        .stub(:get, "https://api.base-api.io/v1/files/file_id/download")
        .to_return(
          body: "TEST")

      client =
        Base::Client.new(access_token: "access_token")

      file =
        client.files.download("file_id")

      file.should be_a(IO::Memory)
      file.gets_to_end.should eq("TEST")
    end
  end

  context "Downloads URL" do
    it "returns the download url of the file" do
      client =
        Base::Client.new(access_token: "access_token")

      client
        .files
        .download_url("file_id")
        .should eq("https://api.base-api.io/v1/files/file_id/download")
    end
  end

  context "Delete File" do
    it "deletes a file" do
      WebMock
        .stub(:delete, "https://api.base-api.io/v1/files/file_id")
        .to_return(
          body: {
            created_at: Time.now.to_rfc2822,
            extension:  "png",
            name:       "test.png",
            size:       100,
            id:         "id",
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      file =
        client.files.delete("file_id")

      file.should be_a(Base::File)
      file.extension.should eq("png")
      file.name.should eq("test.png")
      file.size.should eq(100)
      file.id.should eq("id")
    end
  end
end
