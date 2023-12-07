class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :type, inclusion: { in: %w[Owner Customer] }
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'Invalid email id!!!!' }

  validates :contact,
      presence: true,
      uniqueness: true,format: { with: /\d[0-9]\)*\z/ }
  has_one_attached :picture

  # def self.ransackable_attributes(auth_object = nil)
  #   ["created_at", "email", "encrypted_password", "id", "name", "password", "remember_created_at", "reset_password_sent_at", "reset_password_token", "type", "updated_at"]
  # end

  # def self.ransackable_associations(auth_object = nil)
  #   ["picture_attachment", "picture_blob"]
  # end
end
