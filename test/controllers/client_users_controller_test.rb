require "test_helper"

class ClientUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get client_users_index_url
    assert_response :success
  end

  test "should get show" do
    get client_users_show_url
    assert_response :success
  end

  test "should get new" do
    get client_users_new_url
    assert_response :success
  end

  test "should get create" do
    get client_users_create_url
    assert_response :success
  end

  test "should get edit" do
    get client_users_edit_url
    assert_response :success
  end

  test "should get update" do
    get client_users_update_url
    assert_response :success
  end

  test "should get destroy" do
    get client_users_destroy_url
    assert_response :success
  end
end
