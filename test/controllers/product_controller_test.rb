require "test_helper"

class ProductControllerTest < ActionDispatch::IntegrationTest
  test "should get fetch_product" do
    get product_fetch_product_url
    assert_response :success
  end
end
