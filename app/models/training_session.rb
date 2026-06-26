class TrainingSession < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  belongs_to :machine, optional: true
  has_many :training_sets, dependent: :destroy
  accepts_nested_attributes_for :training_sets

  validates :trained_on, presence: true
  validate :no_duplicate_session

  private

  def no_duplicate_session
    return unless user_id && exercise_id && trained_on
    scope = self.class.where(user_id: user_id, exercise_id: exercise_id, trained_on: trained_on)
    scope = machine_id ? scope.where(machine_id: machine_id) : scope.where(machine_id: nil)
    scope = scope.where.not(id: id) if persisted?
    errors.add(:base, "同じ日付・種目・マシンの組み合わせはすでに記録されています") if scope.exists?
  end
end
