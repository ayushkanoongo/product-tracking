class RemoveColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :serial_number
    remove_column :products, :email
    remove_column :products, :purpose
    remove_column :products, :product_type
    remove_column :products, :covid
    remove_column :products, :status
  end
end
