class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :unit
      t.float :price
      t.date :purchase_date

      t.timestamps
    end
  end
end
