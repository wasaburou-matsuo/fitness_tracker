class TrainingSet < ApplicationRecord
  belongs_to :training_session

  validates :set_number, presence: true, uniqueness: { scope: :training_session_id }
  validates :weight, presence: true
  validates :reps, presence: true
end
