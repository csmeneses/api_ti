require 'test_helper'

class AlbumsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get albums_index_url
    assert_response :success
  end

  test "should get show" do
    get albums_show_url
    assert_response :success
  end

  test "should get create" do
    get albums_create_url
    assert_response :success
  end

  test "should get delete" do
    get albums_delete_url
    assert_response :success
  end

end
