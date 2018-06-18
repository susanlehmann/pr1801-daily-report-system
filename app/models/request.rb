class Request < ApplicationRecord
  belongs_to :user
  belongs_to :requests_type
end
