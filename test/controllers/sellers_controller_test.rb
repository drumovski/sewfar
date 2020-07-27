require 'test_helper'

class SellersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @seller = sellers(:one)
  end

  test "should get index" do
    get sellers_url
    assert_response :success
  end

  test "should get new" do
    get new_seller_url
    assert_response :success
  end

  test "should create seller" do
    assert_difference('Seller.count') do
      post sellers_url, params: { seller: { abn: @seller.abn, about: @seller.about, address_line_1: @seller.address_line_1, address_line_2: @seller.address_line_2, business_name: @seller.business_name, city: @seller.city, country: @seller.country, facebook: @seller.facebook, instagram: @seller.instagram, linkedin: @seller.linkedin, postcode: @seller.postcode, twitter: @seller.twitter, website: @seller.website } }
    end

    assert_redirected_to seller_url(Seller.last)
  end

  test "should show seller" do
    get seller_url(@seller)
    assert_response :success
  end

  test "should get edit" do
    get edit_seller_url(@seller)
    assert_response :success
  end

  test "should update seller" do
    patch seller_url(@seller), params: { seller: { abn: @seller.abn, about: @seller.about, address_line_1: @seller.address_line_1, address_line_2: @seller.address_line_2, business_name: @seller.business_name, city: @seller.city, country: @seller.country, facebook: @seller.facebook, instagram: @seller.instagram, linkedin: @seller.linkedin, postcode: @seller.postcode, twitter: @seller.twitter, website: @seller.website } }
    assert_redirected_to seller_url(@seller)
  end

  test "should destroy seller" do
    assert_difference('Seller.count', -1) do
      delete seller_url(@seller)
    end

    assert_redirected_to sellers_url
  end
end
