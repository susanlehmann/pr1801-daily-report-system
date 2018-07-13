class AddColumnSignDateToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :sign_date, :date
  end
end
