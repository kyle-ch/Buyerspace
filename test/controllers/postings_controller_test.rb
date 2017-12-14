require 'test_helper'

class PostingsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get postings_show_url
    assert_response :success
  end

  test "should get edit" do
    get postings_edit_url
    assert_response :success
  end

  test "should get delete" do
    get postings_delete_url
    assert_response :success
  end

  test "should get offers" do
    get postings_offers_url
    assert_response :success
  end

  test "should get all" do
    get postings_all_url
    assert_response :success
  end

  test "should get create" do
    get postings_create_url
    assert_response :success
  end

end
