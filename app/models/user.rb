class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :analyses, dependent: :destroy
  has_many :league_analyses, through: :analyses

  mount_uploader :pte_script, PteScriptUploader
  
  # has_many :items, through: :analyses
  # alias_attribute :analyzed_items, :items
  
  before_create :generate_token

  def current_league_analyses
    league_analyses.where(league: League.current)
  end

  def analysis_for_item(item)
    analyses.where(item: item).first_or_create
  end

  def league_analysis_for_item(item, league = League.current)
    analysis_for_item(item).league_analyses.find_or_create_by(league: league)
  end

  private
  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(token: random_token)
    end
  end
end
