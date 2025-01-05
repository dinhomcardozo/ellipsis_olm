require "test_helper"

class SegmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get segments_index_url
    assert_response :success
  end

  test "should get show" do
    get segments_show_url
    assert_response :success
  end

  test "should get new" do
    get segments_new_url
    assert_response :success
  end

  test "should get create" do
    get segments_create_url
    assert_response :success
  end

  test "should get edit" do
    get segments_edit_url
    assert_response :success
  end

  test "should get update" do
    get segments_update_url
    assert_response :success
  end

  test "should get destroy" do
    get segments_destroy_url
    assert_response :success
  end
end
