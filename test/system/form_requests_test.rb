require "application_system_test_case"

class FormRequestsTest < ApplicationSystemTestCase
  setup do
    @form_request = form_requests(:one)
  end

  test "visiting the index" do
    visit form_requests_url
    assert_selector "h1", text: "Form Requests"
  end

  test "creating a Form request" do
    visit form_requests_url
    click_on "New Form Request"

    fill_in "Type", with: @form_request.type
    click_on "Create Form request"

    assert_text "Form request was successfully created"
    click_on "Back"
  end

  test "updating a Form request" do
    visit form_requests_url
    click_on "Edit", match: :first

    fill_in "Type", with: @form_request.type
    click_on "Update Form request"

    assert_text "Form request was successfully updated"
    click_on "Back"
  end

  test "destroying a Form request" do
    visit form_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Form request was successfully destroyed"
  end
end
