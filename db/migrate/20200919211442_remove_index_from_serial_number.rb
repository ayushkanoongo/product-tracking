class RemoveIndexFromSerialNumber < ActiveRecord::Migration[6.0]
  def change
  	remove_index :products, :serial_number
  end
end
