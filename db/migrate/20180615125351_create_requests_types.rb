class CreateRequestsTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :requests_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
