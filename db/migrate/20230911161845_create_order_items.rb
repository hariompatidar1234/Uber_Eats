class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :dish, foreign_key: true

      t.timestamps
    end
  end
end
