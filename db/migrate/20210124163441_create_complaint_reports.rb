class CreateComplaintReports < ActiveRecord::Migration[6.0]
  def change
    create_table :complaint_reports do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.string :status, null: false, default: "PENDING"

      t.timestamps
    end
  end
end
