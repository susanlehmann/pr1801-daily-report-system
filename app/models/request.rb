class Request < ApplicationRecord
  belongs_to :user
  belongs_to :requests_type

  enum status: {pending: 0, approved: 1, rejected: 2}

  scope :load_data, -> {
    order(status: :asc, updated_at: :desc)
  }

  scope :same_division, -> {
    joins(:user).where("users.division_id = ?", User.current.division_id)
  }

  scope :search, -> (search_date) {
    where("created_at = ?", search_date)
  }

  def verify(manager)
    return false if manager.nil?
    update_columns(status: :approved, sign_date: Time.zone.now)
  end

  def reject(manager)
    return false if manager.nil?
    update_columns(status: :rejected, sign_date: Time.zone.now)
  end

  def correct_user? user
    self.user == user
  end
end
