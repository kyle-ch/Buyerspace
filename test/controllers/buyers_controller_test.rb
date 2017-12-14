require 'test_helper'

class BuyersControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get buyers_login_url
    assert_response :success
  end

  test "should get create" do
    get buyers_create_url
    assert_response :success
  end

end
