class Restaurant < ApplicationRecord
    belongs_to :owner, foreign_key: 'user_id'
    has_many :dishes, dependent: :destroy
  
    has_one_attached :picture
  
    enum status: { open: 'open', closed: 'closed' }
  
    validates :name, :status, :address, presence: true
    validates :name, uniqueness: { scope: :address, message: 'must be unique for each address' }
end
  
