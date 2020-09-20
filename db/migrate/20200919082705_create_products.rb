class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
    	t.string :serial_number
    	t.string :buyer_name
    	t.string :address
    	t.string :mobile
    	t.string :email
    	t.string :purpose
    	t.string :product_type
    	t.integer :covid
      t.timestamps
    end
    add_index :products, :serial_number, unique: true
  end
end
