require 'test_helper'

class MediaControllerTest < ActionDispatch::IntegrationTest
  test "should POST create & PATCH update & DELETE destroy" do
    se = FactoryGirl.create :sub_entry

    file = fixture_file_upload(Rails.root.join('test/skull.jpg'), 'image/png')
    post "/api/ses/#{se.id}/media", params: {medium: {image: file}}
    assert_response :success
    assert_equal 1, se.media.count

    m = Medium.last
    patch "/api/ses/#{se.id}/media/#{m.id}", params: {medium: {caption: 'skull'}}
    assert_response :success
    assert_equal 'skull', m.reload.caption

    delete "/api/ses/#{se.id}/media/#{m.id}"
    assert_response :success
    assert_equal 0, Medium.count
  end
end
