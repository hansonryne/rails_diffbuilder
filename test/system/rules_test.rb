require "application_system_test_case"

class RulesTest < ApplicationSystemTestCase
  setup do
    @rule = rules(:one)
  end

  test "visiting the index" do
    visit rules_url
    assert_selector "h1", text: "Rules"
  end

  test "creating a Rule" do
    visit rules_url
    click_on "New Rule"

    fill_in "Body", with: @rule.body
    fill_in "Category", with: @rule.category
    fill_in "Language", with: @rule.language_id
    fill_in "More info links", with: @rule.more_info_links
    fill_in "Severity", with: @rule.severity
    fill_in "Title", with: @rule.title
    click_on "Create Rule"

    assert_text "Rule was successfully created"
    click_on "Back"
  end

  test "updating a Rule" do
    visit rules_url
    click_on "Edit", match: :first

    fill_in "Body", with: @rule.body
    fill_in "Category", with: @rule.category
    fill_in "Language", with: @rule.language_id
    fill_in "More info links", with: @rule.more_info_links
    fill_in "Severity", with: @rule.severity
    fill_in "Title", with: @rule.title
    click_on "Update Rule"

    assert_text "Rule was successfully updated"
    click_on "Back"
  end

  test "destroying a Rule" do
    visit rules_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Rule was successfully destroyed"
  end
end
