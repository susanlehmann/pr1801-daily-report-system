class RequestsType < ApplicationRecord
  has_many :requests
  has_many :tasks
end
