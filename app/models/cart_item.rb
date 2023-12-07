class CartItem < ApplicationRecord
  validates :quantity,  presence: true, numericality: { greater_than: 1 }

  belongs_to :cart
  belongs_to :dish

  before_save :total_amount

  def total_amount
    dish_total_amounts = quantity * dish.price
    self.total_amounts = dish_total_amounts
  end
end
