class ChangeColumnStatusToReports < ActiveRecord::Migration[5.1]
  def change
    change_column :reports, :status, :integer, default: 0
  end
end
