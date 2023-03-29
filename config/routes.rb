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

  #Data adding
  post "/category" , to: "data_adding#category"
  post "/subcategory" , to: "data_adding#sub_category"
  post "/carousel" , to: "data_adding#carousel"
  post "/addproduct" , to: "data_adding#add_product"
  post "/deals" , to: "data_adding#deals"
  post "/popularcategory" , to: "data_adding#popular_category"
  post "/popularbanner" , to: "data_adding#popular_banner"
  
  

  #product data showing
  get "/collections/:brand" , to: "product#fetch_brand"
  get "/product" , to: "product#fetch_product"
  get "/category/:category" , to: "product#fetch_category"
  post "/addlike" , to: "product#add_like"
  post "/addcart" , to: "product#add_cart"
  post "/removecart" , to: "product#remove_cart"
  get "/userlikes" , to: "product#liked_products"
  get "/usercarts" , to: "product#cart_products"

  #Home page
  get "/landingpage" , to: "home#home_page"
  get "/landingpage/scroll1" , to: "home#scroll_1"
  
  
end
