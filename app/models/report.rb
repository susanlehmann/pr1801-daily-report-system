class Report < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true
  enum status: {pending: 0, approved: 1, rejected: 2}

  scope :load_data, -> {
    order(status: :asc, updated_at: :desc)
  }

  def verify(manager)
    return false if manager.nil?
    update_columns(status: :approved)
  end

  def reject(manager)
    return false if manager.nil?
    update_columns(status: :rejected)
  end

  def correct_user? user
    self.user == user
  end
end
