class CreateMachines < ActiveRecord::Migration[8.1]
  def change
    create_table :machines do |t|
      t.references :gym, null: false, foreign_key: true
      t.string :name, null: false
      t.text :setting_memo

      t.timestamps
    end
    add_index :machines, [:gym_id, :name], unique: true
  end
end
