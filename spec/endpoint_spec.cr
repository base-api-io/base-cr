require "./spec_helper"

describe Base do
  context "Successfull request" do
    it "returns response" do
      WebMock
        .stub(:get, "https://api.base-api.io/v1//")
        .to_return(body: "BODY")

      endpoint =
        Base::Endpoint.new(
          access_token: "access_token",
          url: "https://api.base-api.io")

      response =
        endpoint.request do
          endpoint.resource.get
        end

      response.body.should eq("BODY")
    end
  end

  context "Unauthorized" do
    it "raises an error" do
      WebMock
        .stub(:get, "https://api.base-api.io/v1//")
        .to_return(
          status: 401,
          body: "")

      endpoint =
        Base::Endpoint.new(
          access_token: "access_token",
          url: "https://api.base-api.io")

      expect_raises(Base::Unauthorized) do
        response = endpoint.request do
          endpoint.resource.get
        end
      end
    end
  end

  context "Some unkown error" do
    it "raises an error" do
      WebMock
        .stub(:get, "https://api.base-api.io/v1//")
        .to_return(
          status: 401,
          body: "")

      endpoint =
        Base::Endpoint.new(
          access_token: "access_token",
          url: "https://api.base-api.io")

      expect_raises(Base::UnkownError) do
        response = endpoint.request do
          fail "FAIL"
        end
      end
    end
  end

  context "Invalid Request" do
    it "raises an error" do
      WebMock
        .stub(:get, "https://api.base-api.io/v1//")
        .to_return(
          status: 422,
          body: {
            error: "ERROR",
            data:  {} of String => String,
          }.to_json)

      endpoint =
        Base::Endpoint.new(
          access_token: "access_token",
          url: "https://api.base-api.io")

      expect_raises(Base::InvalidRequest) do
        response = endpoint.request do
          endpoint.resource.get
        end
      end
    end
  end
end
