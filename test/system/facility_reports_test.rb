require "application_system_test_case"

class FacilityReportsTest < ApplicationSystemTestCase
  setup do
    @facility_report = facility_reports(:one)
  end

  test "visiting the index" do
    visit facility_reports_url
    assert_selector "h1", text: "Facility Reports"
  end

  test "creating a Facility report" do
    visit facility_reports_url
    click_on "New Facility Report"

    fill_in "Title", with: @facility_report.title
    click_on "Create Facility report"

    assert_text "Facility report was successfully created"
    click_on "Back"
  end

  test "updating a Facility report" do
    visit facility_reports_url
    click_on "Edit", match: :first

    fill_in "Title", with: @facility_report.title
    click_on "Update Facility report"

    assert_text "Facility report was successfully updated"
    click_on "Back"
  end

  test "destroying a Facility report" do
    visit facility_reports_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Facility report was successfully destroyed"
  end
end
