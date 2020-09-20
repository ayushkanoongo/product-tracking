class AddReceivedDateToProducts < ActiveRecord::Migration[6.0]
  def change
  	add_column :products, :receive_date, :datetime
  end
end
