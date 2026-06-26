class TrainingSession < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  belongs_to :machine, optional: true
  has_many :training_sets, dependent: :destroy
  accepts_nested_attributes_for :training_sets

  validates :trained_on, presence: true
  validates :exercise_id, uniqueness: { scope: [:user_id, :machine_id, :trained_on] }
end
