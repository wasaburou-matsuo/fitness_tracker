class User < ApplicationRecord
  has_many :gyms, dependent: :destroy
  has_many :exercises, dependent: :destroy
  has_many :training_sessions, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
