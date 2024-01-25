class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members do |t|
      t.string :name
      t.string :father_name
      t.string :mother_name
      t.string :flat_no
      t.integer :nid_no

      t.timestamps
    end
  end
end
