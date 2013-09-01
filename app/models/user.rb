# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  surname         :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#  editor          :boolean          default(FALSE)
#  role            :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :surname, :password, :password_confirmation
  attr_protected :admin, :editor
  has_secure_password

  ROLES = %w[admin moderator editor author banned]

  has_many :courses

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :surname, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 } #, presence:true >>because there is password_digest
  validates :password_confirmation, presence: true 

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end


end
