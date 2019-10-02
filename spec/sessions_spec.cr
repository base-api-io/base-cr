require "./spec_helper"

describe Base do
  context "Sessions" do
    it "authenticates a user" do
      WebMock
        .stub(:post, "https://api.base-api.io/v1/sessions/")
        .to_return(
          body: {
            created_at:  Time.local.to_rfc2822,
            email:       "test@user.com",
            custom_data: nil,
            id:          "id",
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      user =
        client.sessions.authenticate(
          email: "test@user.com",
          password: "12345")

      user.should be_a(Base::User)
      user.email.should eq("test@user.com")
    end
  end
end
