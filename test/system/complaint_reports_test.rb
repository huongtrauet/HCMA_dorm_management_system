require "application_system_test_case"

class ComplaintReportsTest < ApplicationSystemTestCase
  setup do
    @complaint_report = complaint_reports(:one)
  end

  test "visiting the index" do
    visit complaint_reports_url
    assert_selector "h1", text: "Complaint Reports"
  end

  test "creating a Complaint report" do
    visit complaint_reports_url
    click_on "New Complaint Report"

    fill_in "Title", with: @complaint_report.title
    click_on "Create Complaint report"

    assert_text "Complaint report was successfully created"
    click_on "Back"
  end

  test "updating a Complaint report" do
    visit complaint_reports_url
    click_on "Edit", match: :first

    fill_in "Title", with: @complaint_report.title
    click_on "Update Complaint report"

    assert_text "Complaint report was successfully updated"
    click_on "Back"
  end

  test "destroying a Complaint report" do
    visit complaint_reports_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Complaint report was successfully destroyed"
  end
end
