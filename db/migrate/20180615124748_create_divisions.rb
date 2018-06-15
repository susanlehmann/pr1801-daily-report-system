class CreateDivisions < ActiveRecord::Migration[5.1]
  def change
    create_table :divisions do |t|
      t.string :name
      t.integer :manager_id

      t.timestamps
    end
  end
end
