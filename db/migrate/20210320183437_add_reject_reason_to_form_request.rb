class AddRejectReasonToFormRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :form_requests, :note, :string
  end
end
