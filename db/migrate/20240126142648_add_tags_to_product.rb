class AddTagsToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :tags, :string
  end
end
