class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.integer :position_id
      t.integer :division_id
      t.integer :role

      t.timestamps
    end
  end
end
