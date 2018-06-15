class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.integer :user_id
      t.text :content
      t.integer :status
      t.datetime :created_at
      t.datetime :reported_at

      t.timestamps
    end
  end
end
