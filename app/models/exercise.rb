class Exercise < ApplicationRecord
  belongs_to :user
  has_many :training_sessions, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }
end
