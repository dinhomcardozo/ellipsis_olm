require "test_helper"

class GroupCompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get group_companies_index_url
    assert_response :success
  end

  test "should get show" do
    get group_companies_show_url
    assert_response :success
  end

  test "should get new" do
    get group_companies_new_url
    assert_response :success
  end

  test "should get create" do
    get group_companies_create_url
    assert_response :success
  end

  test "should get edit" do
    get group_companies_edit_url
    assert_response :success
  end

  test "should get update" do
    get group_companies_update_url
    assert_response :success
  end

  test "should get destroy" do
    get group_companies_destroy_url
    assert_response :success
  end
end
