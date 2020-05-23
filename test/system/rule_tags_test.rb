require "application_system_test_case"

class RuleTagsTest < ApplicationSystemTestCase
  setup do
    @rule_tag = rule_tags(:one)
  end

  test "visiting the index" do
    visit rule_tags_url
    assert_selector "h1", text: "Rule Tags"
  end

  test "creating a Rule tag" do
    visit rule_tags_url
    click_on "New Rule Tag"

    fill_in "Name", with: @rule_tag.name
    fill_in "Rule", with: @rule_tag.rule_id
    click_on "Create Rule tag"

    assert_text "Rule tag was successfully created"
    click_on "Back"
  end

  test "updating a Rule tag" do
    visit rule_tags_url
    click_on "Edit", match: :first

    fill_in "Name", with: @rule_tag.name
    fill_in "Rule", with: @rule_tag.rule_id
    click_on "Update Rule tag"

    assert_text "Rule tag was successfully updated"
    click_on "Back"
  end

  test "destroying a Rule tag" do
    visit rule_tags_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Rule tag was successfully destroyed"
  end
end
