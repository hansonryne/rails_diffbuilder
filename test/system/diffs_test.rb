require "application_system_test_case"

class DiffsTest < ApplicationSystemTestCase
  setup do
    @diff = diffs(:one)
  end

  test "visiting the index" do
    visit diffs_url
    assert_selector "h1", text: "Diffs"
  end

  test "creating a Diff" do
    visit diffs_url
    click_on "New Diff"

    fill_in "Notes", with: @diff.notes
    fill_in "Path", with: @diff.path
    fill_in "Reason", with: @diff.reason
    fill_in "Review", with: @diff.review_id
    fill_in "Status", with: @diff.status
    click_on "Create Diff"

    assert_text "Diff was successfully created"
    click_on "Back"
  end

  test "updating a Diff" do
    visit diffs_url
    click_on "Edit", match: :first

    fill_in "Notes", with: @diff.notes
    fill_in "Path", with: @diff.path
    fill_in "Reason", with: @diff.reason
    fill_in "Review", with: @diff.review_id
    fill_in "Status", with: @diff.status
    click_on "Update Diff"

    assert_text "Diff was successfully updated"
    click_on "Back"
  end

  test "destroying a Diff" do
    visit diffs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Diff was successfully destroyed"
  end
end
