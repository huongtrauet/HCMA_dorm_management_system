class AddWaitingDayToFormRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :form_requests, :return_date, :datetime
  end
end
