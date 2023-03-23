module UserDetails
    def decode_token(token_value)
        bearer_token = token_value
        bearer_token = bearer_token.split(' ')
        token = bearer_token[1]
        secret = Rails.application.secrets.secret_key_base
        mobileNumber = JWT.decode token , secret  , true , { algorithm: "HS256" }
        mobileNumber = mobileNumber[0].values[0]
        user = User.find_by(MobileNumber: mobileNumber)
        return user
    end
end