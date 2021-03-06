require 'test_helper'

class TracksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tracks_index_url
    assert_response :success
  end

  test "should get show" do
    get tracks_show_url
    assert_response :success
  end

  test "should get create" do
    get tracks_create_url
    assert_response :success
  end

  test "should get delete" do
    get tracks_delete_url
    assert_response :success
  end

end
