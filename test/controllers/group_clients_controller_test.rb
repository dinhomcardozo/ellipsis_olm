require "test_helper"

class GroupClientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get group_clients_index_url
    assert_response :success
  end

  test "should get show" do
    get group_clients_show_url
    assert_response :success
  end

  test "should get new" do
    get group_clients_new_url
    assert_response :success
  end

  test "should get create" do
    get group_clients_create_url
    assert_response :success
  end

  test "should get edit" do
    get group_clients_edit_url
    assert_response :success
  end

  test "should get update" do
    get group_clients_update_url
    assert_response :success
  end

  test "should get destroy" do
    get group_clients_destroy_url
    assert_response :success
  end
end
