class Machine < ApplicationRecord
  belongs_to :gym
  has_many :training_sessions, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :gym_id }
end
