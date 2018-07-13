class AddColumnStatusToRequests < ActiveRecord::Migration[5.1]
  def change
    change_column :requests, :status, :integer, default: 0
  end
end
