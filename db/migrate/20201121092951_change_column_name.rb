class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :buyer_name, :patient_name
  end
end
