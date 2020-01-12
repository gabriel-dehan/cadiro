class Analysis < ApplicationRecord
  belongs_to :item
  belongs_to :user

  has_many :league_analyses, dependent: :destroy
  has_many :leagues, through: :league_analyses

  validates :item, uniqueness: { scope: :user, message: "User already analyzing item" }
end
