class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :uuid, null: false
      t.string :name, null: false
      t.string :sku, null: false
      t.integer :kind, null: false
      t.integer :price, null: false
      t.string :description, null: false

      t.timestamps
    end
  end
end
