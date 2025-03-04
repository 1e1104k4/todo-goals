class User < ApplicationRecord
  has_secure_password
  has_many :goals, dependent: :destroy
  
  attr_accessor :old_password
  
  validates :name, presence: true, uniqueness: true
  validate :verify_old_password, on: :update, if: :password_digest_changed?
  
  private
  
  def verify_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)
    errors.add :old_password, "is incorrect"
  end
end
