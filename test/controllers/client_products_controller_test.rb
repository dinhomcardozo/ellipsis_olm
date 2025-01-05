require "test_helper"

class ClientProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get client_products_index_url
    assert_response :success
  end

  test "should get show" do
    get client_products_show_url
    assert_response :success
  end

  test "should get new" do
    get client_products_new_url
    assert_response :success
  end

  test "should get create" do
    get client_products_create_url
    assert_response :success
  end

  test "should get edit" do
    get client_products_edit_url
    assert_response :success
  end

  test "should get update" do
    get client_products_update_url
    assert_response :success
  end

  test "should get destroy" do
    get client_products_destroy_url
    assert_response :success
  end
end
