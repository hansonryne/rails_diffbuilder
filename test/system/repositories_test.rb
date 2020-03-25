require "application_system_test_case"

class RepositoriesTest < ApplicationSystemTestCase
  setup do
    @repository = repositories(:one)
  end

  test "visiting the index" do
    visit repositories_url
    assert_selector "h1", text: "Repositories"
  end

  test "creating a Repository" do
    visit repositories_url
    click_on "New Repository"

    fill_in "Local copy", with: @repository.local_copy
    fill_in "Name", with: @repository.name
    fill_in "Project", with: @repository.project
    fill_in "Repo location", with: @repository.repo_location
    click_on "Create Repository"

    assert_text "Repository was successfully created"
    click_on "Back"
  end

  test "updating a Repository" do
    visit repositories_url
    click_on "Edit", match: :first

    fill_in "Local copy", with: @repository.local_copy
    fill_in "Name", with: @repository.name
    fill_in "Project", with: @repository.project
    fill_in "Repo location", with: @repository.repo_location
    click_on "Update Repository"

    assert_text "Repository was successfully updated"
    click_on "Back"
  end

  test "destroying a Repository" do
    visit repositories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Repository was successfully destroyed"
  end
end
