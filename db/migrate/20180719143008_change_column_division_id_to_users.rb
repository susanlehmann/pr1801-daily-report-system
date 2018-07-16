class ChangeColumnDivisionIdToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :division_id, :integer, default: 4
  end
end
