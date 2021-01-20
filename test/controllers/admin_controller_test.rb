require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_index_url
    assert_response :success
  end

  test "should get clear_all" do
    get admin_clear_all_url
    assert_response :success
  end
end
