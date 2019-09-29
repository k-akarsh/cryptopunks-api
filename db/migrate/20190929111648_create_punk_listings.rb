class CreatePunkListings < ActiveRecord::Migration[5.2]
  def change
    create_table :punk_listings do |t|
      t.integer :punk_id
      t.boolean :for_sale
      t.string :sale_price

      t.timestamps
    end
  end
end
