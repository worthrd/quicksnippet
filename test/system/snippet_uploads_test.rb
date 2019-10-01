require "application_system_test_case"

class SnippetUploadsTest < ApplicationSystemTestCase
  setup do
    @snippet_upload = snippet_uploads(:one)
  end

  test "visiting the index" do
    visit snippet_uploads_url
    assert_selector "h1", text: "Snippet Uploads"
  end

  test "creating a Snippet upload" do
    visit snippet_uploads_url
    click_on "New Snippet Upload"

    fill_in "Title", with: @snippet_upload.title
    click_on "Create Snippet upload"

    assert_text "Snippet upload was successfully created"
    click_on "Back"
  end

  test "updating a Snippet upload" do
    visit snippet_uploads_url
    click_on "Edit", match: :first

    fill_in "Title", with: @snippet_upload.title
    click_on "Update Snippet upload"

    assert_text "Snippet upload was successfully updated"
    click_on "Back"
  end

  test "destroying a Snippet upload" do
    visit snippet_uploads_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Snippet upload was successfully destroyed"
  end
end
