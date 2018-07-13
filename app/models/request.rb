class Request < ApplicationRecord
  belongs_to :user
  belongs_to :requests_type

  enum status: {pending: 0, approved: 1, rejected: 2}

  scope :load_data, -> {
    order(status: :asc, updated_at: :desc)
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
