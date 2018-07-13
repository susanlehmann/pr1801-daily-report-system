class User < ApplicationRecord
  require "securerandom"
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id",
    dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: "followed_id",
    dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :user_skills
  has_many :skills, through: :user_skills
  has_many :user_parts
  has_many :requests
  has_many :reports
  belongs_to :division
  mount_uploader :avatars, AvatarUploader
  attr_accessor :remember_token, :reset_token
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: Settings.name.maximum}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: Settings.email.maximum },
    format: { with:VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: Settings.password.minimum }, allow_nil: true
  enum role: {user: 0, admin: 1, manager: 2}
  # Return the hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #Return a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent session
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def self.find_or_create_from_auth_hash(auth_hash)
    user = find_or_create_by(provider: auth_hash["provider"], uid: auth_hash["uid"])
    user.update(
      provider: auth_hash["info"]["provider"],
      uid: auth_hash["info"]["uid"],
      name: auth_hash["info"]["name"],
      email: auth_hash["info"]["email"],
      password: SecureRandom.hex,
      avatars: auth_hash["info"]["image"],
      token: auth_hash["credentials"]["token"],
      secret: auth_hash["credentials"]["secret"]
    )
    user.save!
    user
  end

end
