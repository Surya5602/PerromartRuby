class User < ApplicationRecord
    has_many :addresses
    has_many :pets
    has_many :likes
    has_many :carts
    has_many :reviews
    # validates :MobileNumber,format: { with: /\A\+91[6-9][0-9]{9}\z/, message: "Must be a valid mobile number" }
    # validates :MobileNumber , uniqueness: { message: "Mobile number is already registered" }
    # PASSWORD_REGEX = /\A(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}\z/.freeze
    # validates :Password, length: { minimum: 8 }, format: { with: PASSWORD_REGEX, message: "must contain at least one letter and one digit" }
    # validates :Password, presence: { message: "Password can't be blank" }
    # validates :Password, length: { minimum: 8, message: "is too short (minimum is 8 characters)" }
    # validates :Password, format: { with: PASSWORD_REGEX, message: "must contain at least one letter and one digit" }
    # validates :Email , presence: {message: "Email can't be blank"}
    # validates :Email , uniqueness: { message: "Email is already registered" }
    # validates :Email , format: {with: URI::MailTo::EMAIL_REGEXP, message: "Email is not valid" } 
    # validates :DateOfBirth , presence: {message: "Date of birth can't be blank"}
    # validates :Name , presence: {message: "Name can't be blank"}
    # validates :Gender , presence: {message: "Gender can't be blank"}
end
