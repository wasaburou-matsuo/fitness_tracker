class CreateTrainingSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :training_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.references :machine, null: true, foreign_key: true
      t.date :trained_on, null: false
      t.text :memo

      t.timestamps
    end
    execute <<~SQL
      CREATE UNIQUE INDEX index_training_sessions_unique
      ON training_sessions (user_id, exercise_id, COALESCE(machine_id, 0), trained_on);
    SQL
  end
end
