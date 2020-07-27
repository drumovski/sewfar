require "application_system_test_case"

class SellersTest < ApplicationSystemTestCase
  setup do
    @seller = sellers(:one)
  end

  test "visiting the index" do
    visit sellers_url
    assert_selector "h1", text: "Sellers"
  end

  test "creating a Seller" do
    visit sellers_url
    click_on "New Seller"

    fill_in "Abn", with: @seller.abn
    fill_in "About", with: @seller.about
    fill_in "Address line 1", with: @seller.address_line_1
    fill_in "Address line 2", with: @seller.address_line_2
    fill_in "Business name", with: @seller.business_name
    fill_in "City", with: @seller.city
    fill_in "Country", with: @seller.country
    fill_in "Facebook", with: @seller.facebook
    fill_in "Instagram", with: @seller.instagram
    fill_in "Linkedin", with: @seller.linkedin
    fill_in "Postcode", with: @seller.postcode
    fill_in "Twitter", with: @seller.twitter
    fill_in "Website", with: @seller.website
    click_on "Create Seller"

    assert_text "Seller was successfully created"
    click_on "Back"
  end

  test "updating a Seller" do
    visit sellers_url
    click_on "Edit", match: :first

    fill_in "Abn", with: @seller.abn
    fill_in "About", with: @seller.about
    fill_in "Address line 1", with: @seller.address_line_1
    fill_in "Address line 2", with: @seller.address_line_2
    fill_in "Business name", with: @seller.business_name
    fill_in "City", with: @seller.city
    fill_in "Country", with: @seller.country
    fill_in "Facebook", with: @seller.facebook
    fill_in "Instagram", with: @seller.instagram
    fill_in "Linkedin", with: @seller.linkedin
    fill_in "Postcode", with: @seller.postcode
    fill_in "Twitter", with: @seller.twitter
    fill_in "Website", with: @seller.website
    click_on "Update Seller"

    assert_text "Seller was successfully updated"
    click_on "Back"
  end

  test "destroying a Seller" do
    visit sellers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Seller was successfully destroyed"
  end
end
