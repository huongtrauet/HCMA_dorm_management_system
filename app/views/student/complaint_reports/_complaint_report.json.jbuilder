json.extract! complaint_report, :id, :title, :created_at, :updated_at
json.url complaint_report_url(complaint_report, format: :json)
