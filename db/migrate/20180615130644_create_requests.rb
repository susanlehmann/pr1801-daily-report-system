class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.integer :user_id
      t.integer :requests_type_id
      t.integer :status
      t.datetime :created_at
      t.datetime :updated_at
      t.text :reason

      t.timestamps
    end
  end
end
