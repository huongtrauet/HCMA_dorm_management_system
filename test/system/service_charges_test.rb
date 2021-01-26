require "application_system_test_case"

class ServiceChargesTest < ApplicationSystemTestCase
  setup do
    @service_charge = service_charges(:one)
  end

  test "visiting the index" do
    visit service_charges_url
    assert_selector "h1", text: "Service Charges"
  end

  test "creating a Service charge" do
    visit service_charges_url
    click_on "New Service Charge"

    fill_in "Water price", with: @service_charge.water_price
    click_on "Create Service charge"

    assert_text "Service charge was successfully created"
    click_on "Back"
  end

  test "updating a Service charge" do
    visit service_charges_url
    click_on "Edit", match: :first

    fill_in "Water price", with: @service_charge.water_price
    click_on "Update Service charge"

    assert_text "Service charge was successfully updated"
    click_on "Back"
  end

  test "destroying a Service charge" do
    visit service_charges_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Service charge was successfully destroyed"
  end
end
