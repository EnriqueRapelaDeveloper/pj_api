class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.string :uuid, null: false
      t.references :store, null: false, foreign_key: true
      t.integer :total_price, null: true
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    create_table :order_products do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
