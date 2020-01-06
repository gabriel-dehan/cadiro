class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :analyses, dependent: :destroy
  has_many :season_analyses, through: :analyses
  
  # has_many :items, through: :analyses
  # alias_attribute :analyzed_items, :items
  
  before_create :generate_token

  def current_season_analyses
    season_analyses.where(season: Season.current)
  end

  def analysis_for_item(item)
    analyses.where(item: item).first_or_create
  end

  def seasonal_analysis_for_item(item, season = Season.current)
    analysis_for_item(item).season_analyses.find_or_create_by(season: season)
  end

  private
  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(token: random_token)
    end
  end
end
