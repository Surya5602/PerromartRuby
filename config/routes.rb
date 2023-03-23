Rails.application.routes.draw do
  #Login or Signup part
  post "/checkmobile" , to: "user#check_validity"
  post "/resendotp" , to: "user#resend_otp"
  post "/mobileverification" , to: "user#verification"
  post "/userdetails" , to: "user#user_details"  
  post "/userupdation" , to: "user#user_updation"
  post "/addaddress" , to: "user#add_address"
  get "/profilepage" , to: "user#all_details"
  #Add pets to a specific user
  post "/addpet" , to: "pet#add_pet"
  get "/petdetails" , to: "pet#pets_details"

end
