require 'test_helper'

class ServiceChargesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @service_charge = service_charges(:one)
  end

  test "should get index" do
    get service_charges_url
    assert_response :success
  end

  test "should get new" do
    get new_service_charge_url
    assert_response :success
  end

  test "should create service_charge" do
    assert_difference('ServiceCharge.count') do
      post service_charges_url, params: { service_charge: { water_price: @service_charge.water_price } }
    end

    assert_redirected_to service_charge_url(ServiceCharge.last)
  end

  test "should show service_charge" do
    get service_charge_url(@service_charge)
    assert_response :success
  end

  test "should get edit" do
    get edit_service_charge_url(@service_charge)
    assert_response :success
  end

  test "should update service_charge" do
    patch service_charge_url(@service_charge), params: { service_charge: { water_price: @service_charge.water_price } }
    assert_redirected_to service_charge_url(@service_charge)
  end

  test "should destroy service_charge" do
    assert_difference('ServiceCharge.count', -1) do
      delete service_charge_url(@service_charge)
    end

    assert_redirected_to service_charges_url
  end
end
