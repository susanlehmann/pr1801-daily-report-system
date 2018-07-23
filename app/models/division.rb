class Division < ApplicationRecord
  belongs_to :user, foreign_key: :manager_id, class_name: User.name
  has_many :employees, foreign_key: :division_id, class_name: User.name
end
