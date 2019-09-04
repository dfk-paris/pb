require 'test_helper'

class SubEntriesControllerTest < ActionDispatch::IntegrationTest
  test "should GET index" do
    se = FactoryGirl.create :sub_entry
    get '/api/ses'
    assert_response :success
  end

  test "should GET show" do
    se = FactoryGirl.create :sub_entry
    get "/api/ses/#{se.id}"
    assert_response :success
  end

  test "should PATCH update" do
    se = FactoryGirl.create :sub_entry
    patch "/api/ses/#{se.id}", params: {sub_entry: {title: 'Königliche Sitzgruppe'}}
    assert_response :success
    assert_equal 1, SubEntry.count
    assert_equal 'Königliche Sitzgruppe', SubEntry.first.title
  end

  test "should POST create" do
    post '/api/ses', params: {sub_entry: {title: 'Something', sequence: '001'}}
    assert_response :success
    assert_equal 1, SubEntry.count
  end

  test "should DELETE destroy" do
    se = FactoryGirl.create :sub_entry
    delete "/api/ses/#{se.id}"
    assert_response :success
    assert_equal 0, SubEntry.count
  end
end
