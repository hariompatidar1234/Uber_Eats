class Restaurant < ApplicationRecord
  belongs_to :owner, foreign_key: 'user_id'
  has_many :dishes, dependent: :destroy

  has_one_attached :picture

  enum status: { open: 'open', closed: 'closed' }

  validates :name, :status, :address, presence: true
  validates :name, uniqueness: { scope: :address, message: 'must be unique for each address' }

  # def self.ransackable_attributes(auth_object = nil)
  #   ["address", "created_at", "id", "name", "status", "updated_at", "user_id"]
  # end


  # def self.ransackable_associations(auth_object = nil)
  #   ["dishes", "owner", "picture_attachment", "picture_blob"]
  # end
end
