class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :product, foreign_key: true
      t.string :serial_number
    	t.string :item_type
      t.timestamps
    end
  end
end
