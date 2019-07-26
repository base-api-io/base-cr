require "./spec_helper"

describe Base do
  context "Create User" do
    it "creates a user" do
      WebMock
        .stub(:post, "https://api.base-api.io/v1/users/")
        .to_return(
          body: {
            created_at: Time.now.to_rfc2822,
            email:      "test@user.com",
            id:         "id",
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      user =
        client.users.create(
          email: "test@user.com",
          confirmation: "12345",
          password: "12345")

      user.should be_a(Base::User)
      user.email.should eq("test@user.com")
    end
  end

  context "Get User" do
    it "gets a users details" do
      WebMock
        .stub(:get, "https://api.base-api.io/v1/users/user_id")
        .to_return(
          body: {
            created_at: Time.now.to_rfc2822,
            email:      "test@user.com",
            id:         "id",
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      user =
        client.users.get("user_id")

      user.should be_a(Base::User)
      user.email.should eq("test@user.com")
    end
  end

  context "Delete User" do
    it "deletes a users" do
      WebMock
        .stub(:delete, "https://api.base-api.io/v1/users/user_id")
        .to_return(
          body: {
            created_at: Time.now.to_rfc2822,
            email:      "test@user.com",
            id:         "id",
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      user =
        client.users.delete("user_id")

      user.should be_a(Base::User)
      user.email.should eq("test@user.com")
    end
  end
end
