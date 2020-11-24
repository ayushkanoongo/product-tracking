class AddMoreFieldsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :other_mobile, :string
    add_column :products, :remarks, :string
  end
end
