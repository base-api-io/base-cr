require "./spec_helper"

describe Base do
  context "Listing images" do
    it "lists images" do
      WebMock
        .stub(:get, "https://api.base-api.io/v1/images/")
        .to_return(
          body: {
            items: [{
              created_at: Time.now.to_rfc2822,
              name:       "test.png",
              width:      100,
              height:     100,
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
        client.images.list

      list.should be_a(Base::List(Base::Image))
      list.metadata.count.should eq(1)
    end
  end

  context "Create Image" do
    it "creates an image" do
      WebMock
        .stub(:post, "https://api.base-api.io/v1/images/")
        .to_return(
          body: {
            created_at: Time.now.to_rfc2822,
            name:       "test.png",
            width:      100,
            height:     100,
            size:       100,
            id:         "id",
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      image =
        client.images.create(image: File.tempfile)

      image.should be_a(Base::Image)
      image.name.should eq("test.png")
      image.height.should eq(100)
      image.width.should eq(100)
      image.size.should eq(100)
      image.id.should eq("id")
    end
  end

  context "Get Image" do
    it "gets a images details" do
      WebMock
        .stub(:get, "https://api.base-api.io/v1/images/image_id")
        .to_return(
          body: {
            created_at: Time.now.to_rfc2822,
            name:       "test.png",
            width:      100,
            height:     100,
            size:       100,
            id:         "id",
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      image =
        client.images.get("image_id")

      image.should be_a(Base::Image)
      image.name.should eq("test.png")
      image.height.should eq(100)
      image.width.should eq(100)
      image.size.should eq(100)
      image.id.should eq("id")
    end
  end

  context "Downloads Image" do
    it "downloads the image" do
      WebMock
        .stub(:get, "https://api.base-api.io/v1/images/image_id/version?")
        .to_return(
          body: "TEST")

      client =
        Base::Client.new(access_token: "access_token")

      image =
        client.images.download("image_id")

      image.should be_a(IO::Memory)
      image.gets_to_end.should eq("TEST")
    end
  end

  context "Image URL" do
    it "returns the process url of the image" do
      client =
        Base::Client.new(access_token: "access_token")

      client
        .images
        .image_url("image_id")
        .should eq("https://api.base-api.io/v1/images/image_id/version?")
    end
  end

  context "Delete Image" do
    it "deletes an image" do
      WebMock
        .stub(:delete, "https://api.base-api.io/v1/images/image_id")
        .to_return(
          body: {
            created_at: Time.now.to_rfc2822,
            name:       "test.png",
            width:      100,
            height:     100,
            size:       100,
            id:         "id",
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      image =
        client.images.delete("image_id")

      image.should be_a(Base::Image)
      image.name.should eq("test.png")
      image.height.should eq(100)
      image.width.should eq(100)
      image.size.should eq(100)
      image.id.should eq("id")
    end
  end
end
