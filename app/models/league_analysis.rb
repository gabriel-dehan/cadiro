class LeagueAnalysis < ApplicationRecord
  belongs_to :league
  belongs_to :analysis

  has_one :user, through: :analysis
  has_one :item, through: :analysis

  validates :league, uniqueness: { scope: :analysis, message: "Can only analyse item once per league" }
end
