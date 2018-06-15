class User < ApplicationRecord
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  #has_many :user_skills
  has_many :skills, through: :user_skills
  belongs_to :position
  belongs_to :division
  has_many :requests
  has_many :reports
end
