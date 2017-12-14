require 'test_helper'

class SellerControllerTest < ActionDispatch::IntegrationTest
  test "should get all" do
    get seller_all_url
    assert_response :success
  end

  test "should get show" do
    get seller_show_url
    assert_response :success
  end

  test "should get search" do
    get seller_search_url
    assert_response :success
  end

  test "should get tag" do
    get seller_tag_url
    assert_response :success
  end

end
