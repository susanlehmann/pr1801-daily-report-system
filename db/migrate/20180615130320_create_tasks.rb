class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :require_name
      t.integer :requests_type_id

      t.timestamps
    end
  end
end
