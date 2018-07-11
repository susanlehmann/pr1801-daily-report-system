class AddManagerIdToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :manager_id, :integer
  end
end
