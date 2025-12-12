class CreateProperty < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :unique_id, null: false, index: { unique: true }
      t.string :name, null: false
      t.integer :room_number
      t.string :address
      t.integer :rent
      t.integer :size
      t.string :property_type

      t.timestamps
    end
  end
end
