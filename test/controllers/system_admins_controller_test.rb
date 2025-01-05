require "test_helper"

class SystemAdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get system_admins_index_url
    assert_response :success
  end

  test "should get show" do
    get system_admins_show_url
    assert_response :success
  end

  test "should get new" do
    get system_admins_new_url
    assert_response :success
  end

  test "should get create" do
    get system_admins_create_url
    assert_response :success
  end

  test "should get edit" do
    get system_admins_edit_url
    assert_response :success
  end

  test "should get update" do
    get system_admins_update_url
    assert_response :success
  end

  test "should get destroy" do
    get system_admins_destroy_url
    assert_response :success
  end
end
