class SeasonAnalysis < ApplicationRecord
  belongs_to :season
  belongs_to :analysis

  has_one :user, through: :analysis
  has_one :item, through: :analysis

  validates :season, uniqueness: { scope: :analysis, message: "Can only analyse item once per season" }
end
