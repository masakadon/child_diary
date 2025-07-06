require "test_helper"

class GroupRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get group_requests_create_url
    assert_response :success
  end

  test "should get update" do
    get group_requests_update_url
    assert_response :success
  end

  test "should get index" do
    get group_requests_index_url
    assert_response :success
  end
end
