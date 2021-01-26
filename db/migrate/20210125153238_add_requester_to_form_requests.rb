class AddRequesterToFormRequests < ActiveRecord::Migration[6.0]
  def change
    add_reference :form_requests, :requester, null: false, foreign_key: { to_table: :students }
  end
end
