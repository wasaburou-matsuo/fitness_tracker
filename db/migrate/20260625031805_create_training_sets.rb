class CreateTrainingSets < ActiveRecord::Migration[8.1]
  def change
    create_table :training_sets do |t|
      t.references :training_session, null: false, foreign_key: true
      t.integer :set_number, null: false
      t.decimal :weight, precision: 5, scale: 2, null: false
      t.integer :reps, null: false

      t.timestamps
    end
    add_index :training_sets, [:training_session_id, :set_number], unique: true
  end
end
