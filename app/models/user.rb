# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  email            :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  password_digest  :string(255)
#  surname          :string(255)
#  remember_token   :string(255)
#  role             :string(255)
#  perishable_token :string(255)
#  verified         :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :surname, :password, :password_confirmation
  # attr_reader :perishable_token
  attr_protected :role #look at ROLES 
  has_secure_password

  ROLES = %w[admin moderator editor author banned] << nil

  has_many :courses

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  # before_save :generate_perishable_token
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :surname, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 } #, presence:true >>because there is password_digest
  validates :password_confirmation, presence: true 
  validates :role, inclusion: { in: ROLES }

  default_scope order: 'users.surname ASC'


  def deliver_verification_instructions!
    generate_perishable_token 
    Notifier.verify_email(self).deliver
  end


  def self.find_using_perishable_token(token, 
        age = KarvonSaroy::Application.config.PERISHABLE_TOKEN_VALID_FOR)
    return if token.blank?
    age = age.to_i

    conditions_sql = "perishable_token = ?"
    conditions_subs = [token]

    if column_names.include?("updated_at") && age > 0
      conditions_sql += " and updated_at > ?"
      conditions_subs << age.seconds.ago 
    end

    where(conditions_sql, *conditions_subs).first
  end


  def verify!
    self.update_attribute(:verified, true)
    # self.verified = true
    # self.save
  end

  private

    def create_remember_token #used for sessions
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def generate_perishable_token
      # self.perishable_token = SecureRandom.urlsafe_base64
      self.update_attribute(:perishable_token, SecureRandom.urlsafe_base64)
    end



end
