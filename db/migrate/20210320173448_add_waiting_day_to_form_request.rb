class AddWaitingDayToFormRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :form_requests, :return_date, :datetime, default: Time.current.to_date
  end
end
