require 'test_helper'

class SubEntriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sub_entries_index_url
    assert_response :success
  end

  test "should get show" do
    get sub_entries_show_url
    assert_response :success
  end

  test "should get create" do
    get sub_entries_create_url
    assert_response :success
  end

  test "should get update" do
    get sub_entries_update_url
    assert_response :success
  end

  test "should get destroy" do
    get sub_entries_destroy_url
    assert_response :success
  end

end
