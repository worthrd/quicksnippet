require 'test_helper'

class SnippetUploadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @snippet_upload = snippet_uploads(:one)
  end

  test "should get index" do
    get snippet_uploads_url
    assert_response :success
  end

  test "should get new" do
    get new_snippet_upload_url
    assert_response :success
  end

  test "should create snippet_upload" do
    assert_difference('SnippetUpload.count') do
      post snippet_uploads_url, params: { snippet_upload: { title: @snippet_upload.title } }
    end

    assert_redirected_to snippet_upload_url(SnippetUpload.last)
  end

  test "should show snippet_upload" do
    get snippet_upload_url(@snippet_upload)
    assert_response :success
  end

  test "should get edit" do
    get edit_snippet_upload_url(@snippet_upload)
    assert_response :success
  end

  test "should update snippet_upload" do
    patch snippet_upload_url(@snippet_upload), params: { snippet_upload: { title: @snippet_upload.title } }
    assert_redirected_to snippet_upload_url(@snippet_upload)
  end

  test "should destroy snippet_upload" do
    assert_difference('SnippetUpload.count', -1) do
      delete snippet_upload_url(@snippet_upload)
    end

    assert_redirected_to snippet_uploads_url
  end
end
