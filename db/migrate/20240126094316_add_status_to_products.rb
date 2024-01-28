class AddStatusToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :status, :boolean
  end
end
