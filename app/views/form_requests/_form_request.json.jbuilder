json.extract! form_request, :id, :type, :created_at, :updated_at
json.url form_request_url(form_request, format: :json)
