class AddRejectReasonToFormRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :form_requests, :note, :string, default: "We are currently unable to process your request.Any questions please contact the management directly"
  end
end
