require "application_system_test_case"

class PatternsTest < ApplicationSystemTestCase
  setup do
    @pattern = patterns(:one)
  end

  test "visiting the index" do
    visit patterns_url
    assert_selector "h1", text: "Patterns"
  end

  test "creating a Pattern" do
    visit patterns_url
    click_on "New Pattern"

    fill_in "Category", with: @pattern.category
    check "Complete" if @pattern.complete
    fill_in "Description", with: @pattern.description
    fill_in "Difficulty", with: @pattern.difficulty
    fill_in "Fabric", with: @pattern.fabric
    fill_in "Fabric amount", with: @pattern.fabric_amount
    fill_in "Name", with: @pattern.name
    fill_in "Notions", with: @pattern.notions
    fill_in "Price", with: @pattern.price
    fill_in "Sizes", with: @pattern.sizes
    fill_in "Type", with: @pattern.type
    fill_in "User", with: @pattern.user_id
    click_on "Create Pattern"

    assert_text "Pattern was successfully created"
    click_on "Back"
  end

  test "updating a Pattern" do
    visit patterns_url
    click_on "Edit", match: :first

    fill_in "Category", with: @pattern.category
    check "Complete" if @pattern.complete
    fill_in "Description", with: @pattern.description
    fill_in "Difficulty", with: @pattern.difficulty
    fill_in "Fabric", with: @pattern.fabric
    fill_in "Fabric amount", with: @pattern.fabric_amount
    fill_in "Name", with: @pattern.name
    fill_in "Notions", with: @pattern.notions
    fill_in "Price", with: @pattern.price
    fill_in "Sizes", with: @pattern.sizes
    fill_in "Type", with: @pattern.type
    fill_in "User", with: @pattern.user_id
    click_on "Update Pattern"

    assert_text "Pattern was successfully updated"
    click_on "Back"
  end

  test "destroying a Pattern" do
    visit patterns_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pattern was successfully destroyed"
  end
end
