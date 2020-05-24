require "application_system_test_case"

class GrepsTest < ApplicationSystemTestCase
  setup do
    @grep = greps(:one)
  end

  test "visiting the index" do
    visit greps_url
    assert_selector "h1", text: "Greps"
  end

  test "creating a Grep" do
    visit greps_url
    click_on "New Grep"

    check "Custom" if @grep.custom
    fill_in "Repository", with: @grep.repository_id
    fill_in "Results", with: @grep.results
    fill_in "Review", with: @grep.review_id
    fill_in "Rule", with: @grep.rule_id
    fill_in "Search value", with: @grep.search_value
    click_on "Create Grep"

    assert_text "Grep was successfully created"
    click_on "Back"
  end

  test "updating a Grep" do
    visit greps_url
    click_on "Edit", match: :first

    check "Custom" if @grep.custom
    fill_in "Repository", with: @grep.repository_id
    fill_in "Results", with: @grep.results
    fill_in "Review", with: @grep.review_id
    fill_in "Rule", with: @grep.rule_id
    fill_in "Search value", with: @grep.search_value
    click_on "Update Grep"

    assert_text "Grep was successfully updated"
    click_on "Back"
  end

  test "destroying a Grep" do
    visit greps_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Grep was successfully destroyed"
  end
end
