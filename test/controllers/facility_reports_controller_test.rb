require 'test_helper'

class FacilityReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @facility_report = facility_reports(:one)
  end

  test "should get index" do
    get facility_reports_url
    assert_response :success
  end

  test "should get new" do
    get new_facility_report_url
    assert_response :success
  end

  test "should create facility_report" do
    assert_difference('FacilityReport.count') do
      post facility_reports_url, params: { facility_report: { title: @facility_report.title } }
    end

    assert_redirected_to facility_report_url(FacilityReport.last)
  end

  test "should show facility_report" do
    get facility_report_url(@facility_report)
    assert_response :success
  end

  test "should get edit" do
    get edit_facility_report_url(@facility_report)
    assert_response :success
  end

  test "should update facility_report" do
    patch facility_report_url(@facility_report), params: { facility_report: { title: @facility_report.title } }
    assert_redirected_to facility_report_url(@facility_report)
  end

  test "should destroy facility_report" do
    assert_difference('FacilityReport.count', -1) do
      delete facility_report_url(@facility_report)
    end

    assert_redirected_to facility_reports_url
  end
end
