class Report < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true
  enum status: {pending: 0, approved: 1, rejected: 2}

  scope :load_data, -> {
    order(updated_at: :desc, status: :asc)
  }

  scope :same_division, -> {
    joins(:user).where("users.division_id = ?", User.current.division_id)
  }

  def correct_user? user
    self.user == user
  end
end
