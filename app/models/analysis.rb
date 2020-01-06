class Analysis < ApplicationRecord
  belongs_to :item
  belongs_to :user

  has_many :season_analyses, dependent: :destroy
  has_many :seasons, through: :season_analyses

  validates :item, uniqueness: { scope: :user, message: "User already analyzing item" }
end
