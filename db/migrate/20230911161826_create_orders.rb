class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.decimal :order_amount
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
