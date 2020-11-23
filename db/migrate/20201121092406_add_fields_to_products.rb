class AddFieldsToProducts < ActiveRecord::Migration[6.0]
  def change
  	add_column :products, :doctor_name, :string
  end
end
