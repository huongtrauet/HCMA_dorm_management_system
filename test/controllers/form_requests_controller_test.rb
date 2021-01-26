require 'test_helper'

class FormRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @form_request = form_requests(:one)
  end

  test "should get index" do
    get form_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_form_request_url
    assert_response :success
  end

  test "should create form_request" do
    assert_difference('FormRequest.count') do
      post form_requests_url, params: { form_request: { type: @form_request.type } }
    end

    assert_redirected_to form_request_url(FormRequest.last)
  end

  test "should show form_request" do
    get form_request_url(@form_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_form_request_url(@form_request)
    assert_response :success
  end

  test "should update form_request" do
    patch form_request_url(@form_request), params: { form_request: { type: @form_request.type } }
    assert_redirected_to form_request_url(@form_request)
  end

  test "should destroy form_request" do
    assert_difference('FormRequest.count', -1) do
      delete form_request_url(@form_request)
    end

    assert_redirected_to form_requests_url
  end
end
