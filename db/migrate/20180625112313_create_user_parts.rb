class CreateUserParts < ActiveRecord::Migration[5.1]
  def change
    create_table :user_parts do |t|

      t.timestamps
    end
  end
end
