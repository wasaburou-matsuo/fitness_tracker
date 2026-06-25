class Gym < ApplicationRecord
  belongs_to :user
  has_many :machines, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }
end
