require "./spec_helper"

describe Base do
  context "Forgot Password" do
    it "creates a forgot password token" do
      WebMock
        .stub(:post, "https://api.base-api.io/v1/password/")
        .to_return(
          body: {
            forgot_password_token: "token",
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      token =
        client.passwords.forgot_password(
          email: "test@user.com")

      token.should be_a(Base::ForgotPasswordToken)
      token.forgot_password_token.should eq("token")
    end
  end

  context "Setting password with token" do
    it "creates a forgot password token" do
      WebMock
        .stub(:put, "https://api.base-api.io/v1/password/")
        .to_return(
          body: {
            created_at: Time.now.to_rfc2822,
            email:      "test@user.com",
            id:         "id",
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      user =
        client.passwords.set_password(
          forgot_password_token: "token",
          confirmation: "12345",
          password: "12345")

      user.should be_a(Base::User)
      user.email.should eq("test@user.com")
    end
  end
end
