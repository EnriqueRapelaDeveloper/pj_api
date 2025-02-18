class CreateAddressesAndStores < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.string :uuid, null: false
      t.string :street, null: false
      t.integer :number, null: false
      t.string :letter, null: true
      t.integer :postal_code, null: false
      t.string :country, null: false
      t.string :city, null: false

      t.timestamps
    end

    create_table :stores do |t|
      t.string :uuid, null: false
      t.string :name, null: false
      t.string :phone, null: false
      t.string :email, null: false, default: 'kevin.fernandez@pjchile.com'
      t.references :address, null: false

      t.timestamps
    end
  end
end
