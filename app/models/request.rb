class Request < ApplicationRecord
  belongs_to :user
  belongs_to :requests_type

  enum status: {pending: 0, approved: 1, reject: 2,canceled: 3}

  def verify(manager)
    return false if manager.nil? && !can_verify?

    update_columns(manager_id: manager.id, status: "approved", sign_date: Time.zone.now)
  end

  def reject(manager)
    return false if manager.nil? && !can_verify?

    update_columns(manager_id: manager.id, status: "rejected", sign_date: Time.zone.now)
  end

  def can_verify?
    status == "pending"
  end
end
