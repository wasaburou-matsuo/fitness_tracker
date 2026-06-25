class CreateGyms < ActiveRecord::Migration[8.1]
  def change
    create_table :gyms do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
    add_index :gyms, [:user_id, :name], unique: true
  end
end
