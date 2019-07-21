module Base
  # Struct for the fogot password token.
  struct ForgotPasswordToken
    include JSON::Serializable

    getter forgot_password_token : String
  end
end
