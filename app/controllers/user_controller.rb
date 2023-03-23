class UserController < ApplicationController
  include UserDetails

  def check_validity
    mobileNumber = request.body.string
    mobileNumber = JSON.parse(mobileNumber)
    mobileNumber = mobileNumber["MobileNumber"]
    secret = Rails.application.secrets.secret_key_base
    payload = { mobileNumber: mobileNumber }
    if mobileNumber != nil
      checking_mobile = User.find_by(MobileNumber: mobileNumber)
      valid_mobile = User.new(MobileNumber: mobileNumber)
      if checking_mobile.present? == false
        if valid_mobile.valid?
          otp_generation(mobileNumber)
        else
          render json: { status: false, message: valid_mobile.errors.messages.values[0][0] }
      
        end

      else
        token = JWT.encode payload, secret, "HS256"
        render json: { status: true, message: "You where logged in successfully", token: token }
      end
    else
      render json: { status: false, message: "You should provide a mobile number to proceed" }
    end
  end

  def otp_generation(mobile)
    otp = Random.rand(100000...999999)
    puts otp
    mobile_otp = OtpVerification.find_by(MobileNumber: mobile)
    if mobile_otp.present?
      mobile_otp.otp = otp
      mobile_otp.save
      $checked_validity = true
      render json: { status: true, message: "otp is regenerated" }
    else
      otp_table = OtpVerification.new(MobileNumber: mobile, otp: otp)
      otp_table.save
      render json: { status: true, message: "otp is generated" }
      $checked_validity = true
    end
  end

  def resend_otp
    mobileNumber = request.body.string
    mobileNumber = JSON.parse(mobileNumber)
    mobileNumber = mobileNumber["MobileNumber"]
    if mobileNumber != nil
      otp_generation(mobileNumber)
    else
      render json: { status: false, message: "mobile number should not be null" }
      $checked_validity = false
    end
  end

  def verification
    values = request.body.string
    values = JSON.parse(values)
    secret = Rails.application.secrets.secret_key_base
    mobileNumber = values["MobileNumber"]
    otp = values["otp"]
    payload = { mobileNumber: mobileNumber }
    token = JWT.encode payload, secret, "HS256"
    verification = OtpVerification.find_by(MobileNumber: mobileNumber, otp: otp)
    if verification.present?
      user = User.new(MobileNumber: mobileNumber)
      user.save
      render json: { status: true, message: "Verified successfully", token: token }
    else
      render json: { status: false, message: "Otp is wrong" }
    end
  end

  def user_details
    values = request.body.string
    values = JSON.parse(values)
    token = request.headers["Authorization"]
    user = decode_token(token)
    email = values["Email"]
    password = values["Password"]
    if user.present?
      user.Email = email
      user.Password = password
      if user.valid?
        if user.changed?
          user.save
          render json: { status: true, message: "User details updated" }
        else
          render json: { status: false, message: "Same data should not be provided" }
        end
      else
        render json: { status: false, message: user.errors.messages.values[0][0] }
      end
    else
      render json: { status: false, message: "User is not verified yet" }
    end
  end

  def user_updation
    values = request.body.string
    values = JSON.parse(values)
    token = request.headers["Authorization"]
    user = decode_token(token)
    name = values["Name"]
    gender = values["Gender"]
    date_of_birth = Date.parse(values["DateOfBirth"])
    if user.present?
      user.Name = name
      user.Gender = gender
      user.DateOfBirth = date_of_birth
      if user.valid?
        user.save
        render json: { status: true, message: "User details updated successfully" }
      else
        render json: { status: false, message: user.errors.messages.values[0][0] }
      end
    else
      render json: { status: false, message: "There is no user in the given mobile number" }
    end
  end

  def add_address
    values = request.body.string
    values = JSON.parse(values)
    unit_no = values["UnitNo"]
    country = values["Country"]
    address = values["Address"]
    postal_code = values["PostalCode"]
    token = request.headers["Authorization"]
    user = decode_token(token)
    if user.present?
      user.addresses.create(UnitNo: unit_no, Country: country, PostalCode: postal_code, address: address)
      render json: { stauts: true, message: "Address added to the user" }
    else
      render json: { stauts: false, message: "User is not present" }
    end
  end

  def all_details
    token = request.headers["Authorization"]
    user = decode_token(token)
    address = user.addresses.select(:address , :UnitNo , :Country , :PostalCode)
    user_details = {Name: user.Name , Email: user.Email , DateOfBirth: user.DateOfBirth, Gender: user.Gender , MobileNumber: user.MobileNumber}
    render json: {status: true , userDetails: user_details , userAddress: address}   
  end
end
