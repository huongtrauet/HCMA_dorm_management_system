require 'test_helper'

class ComplaintReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @complaint_report = complaint_reports(:one)
  end

  test "should get index" do
    get complaint_reports_url
    assert_response :success
  end

  test "should get new" do
    get new_complaint_report_url
    assert_response :success
  end

  test "should create complaint_report" do
    assert_difference('ComplaintReport.count') do
      post complaint_reports_url, params: { complaint_report: { title: @complaint_report.title } }
    end

    assert_redirected_to complaint_report_url(ComplaintReport.last)
  end

  test "should show complaint_report" do
    get complaint_report_url(@complaint_report)
    assert_response :success
  end

  test "should get edit" do
    get edit_complaint_report_url(@complaint_report)
    assert_response :success
  end

  test "should update complaint_report" do
    patch complaint_report_url(@complaint_report), params: { complaint_report: { title: @complaint_report.title } }
    assert_redirected_to complaint_report_url(@complaint_report)
  end

  test "should destroy complaint_report" do
    assert_difference('ComplaintReport.count', -1) do
      delete complaint_report_url(@complaint_report)
    end

    assert_redirected_to complaint_reports_url
  end
end
